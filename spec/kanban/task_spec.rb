require 'spec_helper'

describe Task do
  subject{Task.new("name")}

  it "should have name" do
    subject.name.should_not be_nil
  end
end