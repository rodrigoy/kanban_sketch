require 'rubygems'
require 'sinatra'
require 'erb'
require 'uri'

require File.dirname(__FILE__) + '/lib/kanban_to_table'
require File.dirname(__FILE__) + '/lib/dsl_to_kanban'
require File.dirname(__FILE__) + '/lib/kanban'

set :views, File.dirname(__FILE__) + '/views'

get '/' do
  
  @dsl_text = "
To do=Find a date,Get a job,Car Wash,Fix the chair;
In Progress:2=Homework, Watch TV, Surf on the Internet;
Done=Breakfast,Bed,Wake Up;"
  @table = KanbanToTable.render(DSLToKanban.render(@dsl_text))
  erb :index
end

post "/render" do
  redirect '/' + URI.escape(params[:dsl])
end

get "/:text" do
  @dsl_text = URI.unescape(params[:text])
  begin
    @table = KanbanToTable.render(DSLToKanban.render(@dsl_text))
  rescue RuntimeError => error
    @message = error.message
  end
  erb :index
end



