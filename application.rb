require 'rubygems'
require 'sinatra'
require 'erb'
require 'uri'

require File.dirname(__FILE__) + '/lib/kanban_to_table'
require File.dirname(__FILE__) + '/lib/dsl_to_kanban'
require File.dirname(__FILE__) + '/lib/kanban'

set :views, File.dirname(__FILE__) + '/views'

get '/' do
  
  #this is spike code    
  kanban = Kanban.new
  kanban.add_stage('selected').
    add_card('A').add_card('B').add_card('R').add_card('T')
  kanban.add_stage('development', limit=5).
    add_substage('acceptance', limit=1).
      add_card('C').add_card('Z')
  kanban.stages[1].
    add_substage('in progress', limit=3).
      add_card('Q').add_card('Y').add_card('W')
  kanban.stages[1].
    add_substage('done')

  kanban.add_stage('deployment', limit=3).add_card('E')
  kanban.add_stage('in production').
    add_card('F').add_card('K').add_card('L').add_card('M').add_card('N')

  @table = KanbanToTable.render(kanban)
  erb :index
end

post "/render" do
  redirect '/' + URI.encode(params[:dsl], '()[] ')
end

get "/:text" do
  @dsl_text = URI.decode(params[:text])
  @table = KanbanToTable.render(DSLToKanban.render(@dsl_text))
  erb :index
end



