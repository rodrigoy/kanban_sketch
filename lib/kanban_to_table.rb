require 'ostruct'

class KanbanToTable
  
  def self.render(kanban)

    table = OpenStruct.new()
    table.th = []
    table.td = []
    kanban.stages.each do |stage| 
      
      th = OpenStruct.new()
      th.p1 = stage.limit > 0 ? stage.limit : ''
      th.violated = stage.wip_limit_violated?
      th.p2 = stage.name
      
      table.th << th
      table.td << stage.cards
    end

    return table
  end

end
