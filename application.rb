require 'rubygems'
require 'sinatra'
require 'erb'
require File.dirname(__FILE__) + '/lib/kanban_to_table'
require File.dirname(__FILE__) + '/lib/kanban'

set :views, File.dirname(__FILE__) + '/views'

get '/' do
  
  #this is spike code    
  kanban = Kanban.new
  kanban.add_stage('selected').stages[0].add_card('A').add_card('B')
  kanban.add_stage('development', limit=4).
    stages[1].
      add_substage('acceptance', limit=1).
        substages[0].add_card('C').add_card('Z')
  kanban.
    stages[1].
      add_substage('in progress', limit=2).
        substages[1].add_card('E').add_card('Y')
  kanban.
    stages[1].
      add_substage('done!').
        substages[2].add_card('W').add_card('G')

  kanban.add_stage('deployment', limit=3).stages[2].add_card('E')
  kanban.add_stage('in production').stages[3].add_card('F')

  @table = KanbanToTable.render(kanban)
  erb :index
end



