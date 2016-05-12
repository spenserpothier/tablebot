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
