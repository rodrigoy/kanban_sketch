require 'spec_helper'

describe Kanban do
  describe ".parse" do
    context "with a valid yaml file" do
      before(:each) do
        @file = File.expand_path(File.dirname(__FILE__) + '/samples/board1.yml')
      end
      it "should parse" do
        Kanban.parse(@file)
      end
    end

    context "with a invalid yaml file" do
      before(:each) do
        @file = File.expand_path(File.dirname(__FILE__) + '/samples/asdfasdf.yml')
      end
      it "should raise an error" do
        lambda{Kanban.parse @file}.should raise_error
      end
    end
  end
end