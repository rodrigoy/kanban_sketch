describe 'Main application screens' do
  
  it 'should respond to /' do
    get('/').should == "Hello, world!"
  end
  
end