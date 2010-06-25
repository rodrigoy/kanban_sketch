require "spec_helper"

describe DslToKanban do
  describe "#parse" do
    context "with a valid kanban text" do
      before(:each) do
        @text = "one_stage:1"
        @parser = DslToKanban.new(@text)
        @kanban = @parser.parse
      end
      it "should parse" do
        @kanban.should_not be_nil
      end
    end
  end
end