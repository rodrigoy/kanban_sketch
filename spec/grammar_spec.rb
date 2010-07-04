require 'treetop'
require File.dirname(__FILE__) + '/../lib/grammar'

describe KanbanDSL do

  it "should render Stages with Cards" do
    parser = KanbanDSLParser.new()
    sel = parser.parse("selected(A,B,C)") ## it should return the syntactical tree, but returns nil

    sel.should_not be_nil
    sel.respond_to?(:stories).should be_true
    parser.failure_reason.should be_nil

  end
end
