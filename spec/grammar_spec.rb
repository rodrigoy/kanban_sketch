require 'treetop'
require File.dirname(__FILE__) + '/../lib/grammar'

describe KanbanDSL do

  it "should render Stages with Cards" do
    parser = KanbanDSLParser.new()
    puts parser.parse("selected(A,B)") ## it should return the syntactical tree, but returns nil
    puts parser.failure_reason

  end
end
