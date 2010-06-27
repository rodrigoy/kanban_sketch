require 'spec_helper'

describe Kanban do
  subject{Kanban.new}
  it "should have stages" do
    subject.stages.should_not be_nil
  end
  it "should have name" do
    subject.should respond_to(:name)
  end
end
