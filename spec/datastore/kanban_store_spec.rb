require 'spec_helper'

describe KanbanStore do
  
  @dsl_text = "to do=A,B,C,D.\n\rin progress:2=E,F,G,H.\n\rdone=I,J,K."

  before(:each) do
    KanbanStore.delete_all    
  end

  it "should save kanbans" do
    KanbanStore.save!(@dsl_text).should eql(1)
    KanbanStore.save!("to do=A,B,C,D.\n\rin progress:2=E,F,G,H.\n\rdone=I,J,K,L,M.").should eql(2)
  end

  it "should not duplicate records for the same dsl" do
    KanbanStore.save!(@dsl_text).should eql(1)
    KanbanStore.save!(@dsl_text).should eql(1)
  end

  it "should restore kanbans by _id" do
    KanbanStore.save!(@dsl_text).should eql(1)
    KanbanStore.find(1)['dsl_text'].should eql(@dsl_text)
  end

  it "should return nil if not found" do
    KanbanStore.find(1).should be_nil
  end

  after(:each) do
    KanbanStore.delete_all    
  end

end

