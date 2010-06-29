require 'spec_helper'
require 'test/unit'
require 'rack/test'

set :environment, :test

describe 'Main application screens' do

  include Rack::Test::Methods

  def app
    Sinatra::Application
  end
    
  it 'should respond to /' do
    get '/'
    last_response.should be_ok
  end

end
