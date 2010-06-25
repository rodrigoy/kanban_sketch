require 'spec_helper'

describe Stage do
  subject{Stage.new("name", 1)}

  it "should have limit" do
    subject.limit.should be_eql(1)
  end

  it "should have name" do
    subject.name.should be_eql("name")
  end

  it "should have tasks" do
    subject.tasks.should be_eql([])
  end

  it "should have substages" do
    subject.substages.should be_eql([])
  end
end
