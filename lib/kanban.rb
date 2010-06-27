require "kanban/stage"
require "kanban/card"

class Kanban
  attr_accessor :name, :stages
  def initialize
    self.stages = []
  end
end