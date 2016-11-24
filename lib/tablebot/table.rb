require_relative 'tables'
require_relative 'table_item'

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

  # This method parses a table from /r/behindthetables 
  def parse
    lines = @text.split("\n")
    head = lines.shift
    head = head.gsub(/[[:punct:]]/, '')
    #head = head.gsub(/[[:space:]]|\t/, '')
    head_match = Tables::Header_regex.match(head.strip)
    if head_match then
      @die = head_match[2].to_i
      @header = head_match[3].strip
    end
    lines.each { |l|
      l = l.gsub(/[[:punct:]]/, '')
      ti = Tables::Line_regex.match(l.strip)
      if ti then
        @outcomes << TableItem.new(ti.to_s)
      end
    }
  end
end

