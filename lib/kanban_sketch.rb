
['kanban_to_table', 'dsl_to_kanban', 'kanban'].each do |file|
  require "kanban_sketch/#{file}"
end
