require 'ostruct'

class KanbanToTable
  
  def self.render(kanban)

    table = OpenStruct.new()
    table.th1 = []
    table.th2 = []
    table.td = []
    kanban.stages.each do |stage| 
      
      th1 = OpenStruct.new()
      th1.p1 = stage.limit > 0 ? stage.limit : ''
      th1.violated = stage.wip_limit_violated?
      th1.p2 = stage.name
      th1.rowspan = kanban.has_substages? && stage.substages.empty? ? 2 : 1;
      th1.colspan = kanban.has_substages? && !stage.substages.empty? ? stage.substages.size : 1;
      
      table.th1 << th1
      table.td << stage.cards if stage.substages.empty?

      stage.substages.each do |substage|       
        th2 = OpenStruct.new()
        th2.p1 = substage.limit > 0 ? substage.limit : ''
        th2.violated = substage.wip_limit_violated?
        th2.p2 = substage.name

        table.th2 << th2        
        table.td << substage.cards
      end

    end

    return table
  end

end
