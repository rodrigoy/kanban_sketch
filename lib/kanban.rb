require "kanban/stage"
require "kanban/card"

class Kanban
  attr_accessor :stages
  def initialize
    self.stages = []
  end
end