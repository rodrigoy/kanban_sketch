lib_dir = File.expand_path(File.join(File.dirname(__FILE__), 'lib'))
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'rubygems'
require 'sinatra'
require 'erb'
require 'uri'
require 'environment'

require 'kanban_sketch'

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
  get_table_by params[:text]
  erb :index
end

get '/play/' do
  get_table_by '1'
  erb :playground
end

# playground implementation
get '/play/:text' do
  get_table_by params[:text]
  erb :playground
end

def get_table_by(text)
  @text = URI.unescape(text)
  
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
  
end



