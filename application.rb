require 'rubygems'
require 'sinatra'
require 'erb'
require File.dirname(__FILE__) + '/lib/kanban_to_table'
require File.dirname(__FILE__) + '/lib/kanban'

set :views, File.dirname(__FILE__) + '/views'

get '/' do
  kanban = Kanban.new
  kanban.add_stage('selected').stages[0].add_card('A').add_card('B')
  kanban.add_stage('development').stages[1].add_card('C')
  kanban.add_stage('deployment', limit=3).stages[2].add_card('E')
  @table = KanbanToTable.render(kanban)
  erb :index
end



