require 'rubygems'
require 'sinatra'
require 'erb'

set :views, File.dirname(__FILE__) + '/views'

get '/' do
  @hello = 'World'  
  erb :index
end


