require "kanban/stage"
require "kanban/task"

class Kanban
  attr_accessor :stages
  def initialize
    self.stages = []
  end

  def self.parse(text)
    parser = DSLToKanban.new(line)
    parser.parse
  end
end