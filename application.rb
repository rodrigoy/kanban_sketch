require 'rubygems'
require 'sinatra'
require 'erb'
require 'uri'

require File.dirname(__FILE__) + '/lib/kanban_to_table'
require File.dirname(__FILE__) + '/lib/dsl_to_kanban'
require File.dirname(__FILE__) + '/lib/kanban'
require File.dirname(__FILE__) + '/lib/datastore/kanban_store'
require File.dirname(__FILE__) + '/lib/url_shortener_helper'

set :views, File.dirname(__FILE__) + '/views'

get '/' do
  
  @dsl_text = "
To do=Find a date,Get a job,Car Wash,Fix the chair.
In Progress:2=Homework, Watch TV, Surf on the Internet.
Done=Breakfast,Bed,Wake Up."
  @table = KanbanToTable.render(DSLToKanban.render(@dsl_text))
  erb :index
end

post "/render" do
  redirect '/' + URI.escape(params[:dsl])
end


# :text is a DSL text or a short URL key
get "/:text" do

  @text = URI.unescape(params[:text])
  
  #try to find the @text as short URL key
  kanban_id = URLShortenerHelper.to_kanban_id(@text) if @text.length <= 13
  document = KanbanStore.find(kanban_id)

  @dsl_text = document ? document['dsl_text'] : @text

  begin
    @table = KanbanToTable.render(DSLToKanban.render(@dsl_text))
    kanban_id = KanbanStore.save!(@dsl_text)
    @short_url_id = URLShortenerHelper.to_url_key(kanban_id)
  rescue RuntimeError => error
    @message = error.message
  end
  
  erb :index
end



