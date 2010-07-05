require 'treetop'
require File.dirname(__FILE__) + '/../lib/grammar'

describe KanbanDSL do

  it "should render Stages with Cards" do
    parser = KanbanDSLParser.new()
    sel = parser.parse("selected(A,B,C);" + 
      "development[in progress(D,E)];")

    sel.should_not be_nil
    puts sel
    ## sel.respond_to?(:cards).should be_true
    sel.elements.each do |x|
      puts x.text_value
      x.elements.each {|y| puts "  " + y.text_value} if x.elements
    end
    ## parser.failure_reason.should be_nil

  end
end
