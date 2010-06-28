require 'spec_helper'

describe Stage do
  subject{Stage.new(" name ", "1")}

  it "should have limit as a number" do
    subject.limit.should == 1
  end

  it "should have name without spaces at begin and end" do
    subject.name.should be_eql("name")
  end

  it "should have cards" do
    subject.cards.should be_eql([])
  end

  it "should have substages" do
    subject.substages.should be_eql([])
  end
end
