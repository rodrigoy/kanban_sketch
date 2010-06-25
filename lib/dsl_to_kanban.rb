class DslToKanban
  attr_accessor :line
  def initialize(line)
    self.line = line
  end
  def parse
    Kanban.new
  end
end