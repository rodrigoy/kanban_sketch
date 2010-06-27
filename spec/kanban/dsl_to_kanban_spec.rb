require "spec_helper"

describe DslToKanban do
  subject{ DslToKanban.new "" }

  describe "#card?" do
    context "with a line that start with -" do
      it do
        subject.card?("- Misplaced card name").should be_false
      end
    end
    context "with a line that start with --" do
      it do
        subject.card?("-- Misplaced card name").should be_false
      end
    end
    context "with a line that does not start with - or --" do
      it do
        subject.card?("Card name").should be_true
      end
    end
  end

  describe "#stage?" do
    context "with a line that start with -" do
      it do
        subject.stage?("- Stage name").should be_true
      end
    end
    context "with a line that start with --" do
      it do
        subject.stage?("-- Stage name").should be_false
      end
    end
  end

  describe "#substage?" do
    context "with a line that start with -" do
      it do
        subject.substage?("- Misplaced substage name").should be_false
      end
    end
    context "with a line that start with --" do
      it do
        subject.substage?("-- Stage name").should be_true
      end
    end
  end

  describe "#parse" do
    context "with a kanban of 1 stage, 1 substage and one card" do
      before(:each) do
        @text = <<-KB
Kanban name
- Stage
-- Subtage
Card 1 inside Substage
        KB
        @parser = DslToKanban.new(@text)
        @kanban = @parser.parse
      end
      it do
        @kanban.should_not be_nil
      end
      it do
        @kanban.should have(1).stages
      end
    end

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