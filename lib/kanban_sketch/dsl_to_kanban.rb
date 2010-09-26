require 'treetop'
require 'kanban_sketch/grammar'

class DSLToKanban

  def self.render(dsl_text)
    
    kanban = Kanban.new()
    begin    
      parser = KanbanDSLParser.new()
      tree = parser.parse(dsl_text)
      raise parser.failure_reason if parser.failure_reason

      last_added_stage = nil
   
      tree.stages.each do |stage|
        if (!stage.substage?)
          last_added_stage = kanban.add_stage(stage.name, limit=stage.limit, stage.cards)
        elsif
          last_added_stage.add_substage(stage.name, limit=stage.limit, stage.cards)
        end
      end
    rescue RuntimeError => error
      raise 'Syntax Error! ' + error.message
    rescue NoMethodError => error    
      raise 'Syntax Error!'
    end
    return kanban
  end
end


