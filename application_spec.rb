require 'application'
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
    last_response.body.should == "Hello, world!"
  end

end