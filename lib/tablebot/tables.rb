require_relative 'table'

class Tables
  Header_regex = /^(\d+)?[dD](\d+)(.*)/
  Line_regex = /^(\d+)(\s*-+\s*\d+)?(.*)/
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
      line_match = Tables::Header_regex.match(line.strip)
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
