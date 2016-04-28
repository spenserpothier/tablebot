require 'redditkit'
require 'pry'
require 'erb'

Header_regex = /^(\d+)?[dD](\d+)(.*)/
Line_regex = /^(\d+)(\s*-+\s*\d+)?(.*)/

class Tables
  attr_reader :tables
  def initialize(text)
    @text = text
    @tables = []
    parse
  end

  def parse
    indicies = []
    lines = @text.split("\n")
    lines.reject! {|l| l.nil? || l.strip.empty?}
    lines.map.with_index { |line, i|
      line = line.gsub(/[[:punct:]]/, '')
      line_match = Header_regex.match(line.strip)
      if line_match then
        indicies.push(i)
      end
    }
    return 0 unless indicies.length != 0

    table_text = []
    ((0...(indicies.length-1)).to_a).each { |i|
      t = lines[indicies[i]..(indicies[i+1]-1)]
      table_text.push(t.join("\n"))
    }

    table_text.each { |t|
      @tables << Table.new(t)
    }
  end
end

class Table
  attr_reader :die, :header, :outcomes
  def initialize(text)
    @text = text
    @die = nil
    @header = ""
    @outcomes = []
    @is_inline = false
    parse
  end

  def parse
    lines = @text.split("\n")
    head = lines.shift
    head = head.gsub(/[[:punct:]]/, '')
    #head = head.gsub(/[[:space:]]|\t/, '')
    head_match = Header_regex.match(head.strip)
    if head_match then
      @die = head_match[2].to_i
      @header = head_match[3].strip
    end
    lines.each { |l|
      l = l.gsub(/[[:punct:]]/, '')
      ti = Line_regex.match(l.strip)
      if ti then
        @outcomes << TableItem.new(ti.to_s)
      end
    }
  end
end

class TableItem
  attr_reader :outcome, :weight
  def initialize(text)
    @text = text
    @inline_table = nil
    @outcome = ""
    @weight = 0
    parse
  end

  def parse
    main_regex = Line_regex.match(@text)
    if not main_regex then
      return
    end
    @outcome = main_regex[3].strip
    @weight = main_regex[1].to_i
    # else
    #   start = main_regex[1].to_i
    #   stop = main_regex[2].to_i
    #   @weight = stop - start + 1
    # rescue
    #   @weight = 1
    #if /[dD]\d+/.match(@outcome)

  end
end


File.open('barbarians', 'r') { |f|
  a = f.read()
  tb = Tables.new(a)
  renderer = ERB.new(File.read('./table.erb.html'))
  output = renderer.result(binding)
  File.write('./output.html', output)
}
