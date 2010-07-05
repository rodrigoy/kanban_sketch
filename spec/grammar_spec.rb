require 'treetop'
require File.dirname(__FILE__) + '/../lib/grammar'

describe KanbanDSL do

  it "should render Stages with Cards" do
    parser = KanbanDSLParser.new()
    sel = parser.parse("selected:2(A,B,C);" + 
      "development:5[in progress:2(D,E)][done()];" +
      "deploy(F,G,H,I);")

    sel.should_not be_nil
    sel.elements.each do |x|
      puts x.text_value
      x.elements.each {|y| puts "  " + y.text_value} if x.elements
    end
    ## parser.failure_reason.should be_nil

  end
end
