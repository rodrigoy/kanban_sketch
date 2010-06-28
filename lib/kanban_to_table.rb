require 'ostruct'

class KanbanToTable
  
  def self.render(kanban)

    table = OpenStruct.new()
    table.th = OpenStruct.new()
    table.tr = OpenStruct.new()
    table.th.td = []
    table.tr.td = []
    kanban.stages.each do |stage| 
      tdc = OpenStruct.new()
      tdc.p1 = stage.limit > 0 ? stage.limit : ''
      tdc.p2 = stage.name
      table.th.td << tdc
      table.tr.td << render_cards(stage)
    end

    return table
  end

  #todo: definetely there's a better rubism for this  
  def self.render_cards(stage)
    div = []
    stage.cards.each do |card|
      div << card 
    end
    return div
  end
end
