require File.dirname(__FILE__) + '/kanban/stage'
require File.dirname(__FILE__) + '/kanban/card'

class Kanban
  attr_accessor :stages
  
  def initialize
    self.stages = []
  end
  
  def add_stage(name, limit=0)
    stage = Stage.new(name, limit)
    self.stages << stage
    return self
  end  
end
