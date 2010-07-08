require 'treetop'
require File.dirname(__FILE__) + '/../lib/grammar'

class DSLToKanban

  def self.render(dsl_text)
    
    parser = KanbanDSLParser.new()
    tree = parser.parse(dsl_text)
    raise parser.failure_reason if parser.failure_reason

    kanban = Kanban.new()
    
    tree.stages.each do |stage|
      new_stage = kanban.add_stage(stage.name.text_value, limit=stage.limit)
      new_stage.add_cards(stage.body.cards.text_value) if stage.body.respond_to?(:cards);
      
      if stage.body.respond_to?(:substages)    
        stage.body.substages.each do |substage|
          new_substage = new_stage.add_substage(substage.name.text_value, limit=substage.limit)
          new_substage.add_cards(substage.cards.text_value)
        end
      end

    end
    return kanban
  end
end
