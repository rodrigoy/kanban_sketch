require 'spec_helper'

describe Kanban do
  subject{Kanban.new}
  
  it "should have stages" do
    subject.stages.should_not be_nil
  end

  it "should add stages by name" do
    subject.add_stage('to do')
    subject.add_stage('in progress')
    subject.stages.size.should eql(2)
  end

  it "should add stages by name and limit" do
    subject.add_stage('to do', limit=2).limit.should eql(2)
  end
  
  it "should add stages by name, limit and cards" do
    subject.add_stage('to do', limit=2, 'B,C,D,E').cards[2].should eql('D')
  end

  it "should know if it has substages" do
    simple_kanban.has_substages?.should be_false
    kanban_with_substages.has_substages?.should be_true
  end

  def simple_kanban
    kanban = Kanban.new()
    kanban.add_stage('selected')
    kanban.add_stage('development')
    return kanban
  end

  def kanban_with_substages
    kanban = Kanban.new
    kanban.add_stage('development').add_substage('in progress')
    return kanban
  end
end
