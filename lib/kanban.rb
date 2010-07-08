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
    return stage
  end  

  def has_substages?
    !(stages.select {|stage| !stage.substages.empty?}).empty?
  end 
end
