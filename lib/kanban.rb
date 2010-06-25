require "kanban/stage"
require "kanban/task"

class Kanban
  attr_accessor :stages
  def initialize
    self.stages = []
  end
end