require 'spec_helper'

describe Kanban do
  subject{Kanban.new}
  
  it "should have stages" do
    subject.stages.should_not be_nil
  end

  it "should add stages by name" do
    subject.add_stage('to do').add_stage('in progress').stages.size.should eql(2)
  end

  it "should add stages by name and limit" do
    subject.add_stage('to do', limit=2).stages[0].limit.should eql(2)
  end

  it "should add cards to stages" do
    subject.add_stage('to do').stages[0].add_card('A').add_card('B').cards.size.should eql(2)
  end

end
