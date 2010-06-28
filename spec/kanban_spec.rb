require 'spec_helper'

describe Kanban do
  subject{Kanban.new}
  
it "should have stages" do
    subject.stages.should_not be_nil
  end

  it "should add stages by name" do
    subject.add_stage 'to do'
    subject.add_stage 'in progress'
    subject.stages.size.should eql(2)
  end
end
