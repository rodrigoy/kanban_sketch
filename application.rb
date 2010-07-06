require 'rubygems'
require 'sinatra'
require 'erb'
require File.dirname(__FILE__) + '/lib/kanban_to_table'
require File.dirname(__FILE__) + '/lib/kanban'

set :views, File.dirname(__FILE__) + '/views'

get '/' do
  
  #this is spike code    
  kanban = Kanban.new
  kanban.add_stage('selected').stages[0].add_card('A').add_card('B').add_card('R').add_card('T')
  kanban.add_stage('development', limit=5).
    stages[1].
      add_substage('acceptance', limit=1).
        substages[0].add_card('C').add_card('Z')
  kanban.
    stages[1].
      add_substage('in progress', limit=3).
        substages[1].add_card('Q').add_card('Y').add_card('W')
  kanban.
    stages[1].
      add_substage('done').
        substages[2]

  kanban.add_stage('deployment', limit=3).stages[2].add_card('E')
  kanban.add_stage('in production').stages[3].add_card('F').add_card('K').add_card('L').add_card('M').add_card('N')

  @table = KanbanToTable.render(kanban)
  erb :index
end



