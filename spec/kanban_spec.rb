require 'spec_helper'

describe Kanban do
  describe ".parse" do
    context "with a valid kanban text" do
      before(:each) do
        @text = "one_stage:1"
        @kanban = Kanban.parse(@text)
      end
      it "should parse" do
        @kanban.should_not be_nil
      end
      context "with 1 stage" do
        it "should have 1 stage" do
          @kanban.should have(1).stages
        end
      end
    end
  end
end
