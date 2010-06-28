require "kanban/stage"
require "kanban/card"

class Kanban
  attr_accessor :stages
  
  def initialize
    self.stages = []
  end
  
  def add_stage name
    stage = Stage.new(name)
    self.stages << stage
  end  
end
