require 'spec_helper'

describe Card do
  
  it "should set the card name" do
    Card.new('Surf all the internet').name.should == 'Surf all the internet'
  end
  
end