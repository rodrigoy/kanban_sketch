require 'kanban_sketch/kanban/stage'
require 'kanban_sketch/kanban/card'

class Kanban
  attr_accessor :stages
  
  def initialize
    self.stages = []
  end
  
  def add_stage(name, limit=0, cards='')
    stage = Stage.new(name, limit)
    stage.add_cards(cards)
    self.stages << stage
    return stage
  end  

  def has_substages?
    !(stages.select {|stage| !stage.substages.empty?}).empty?
  end 
end
