require 'treetop'
require File.dirname(__FILE__) + '/../lib/grammar'

describe KanbanDSL do

  it "should render simple stage with cards" do
    parser = KanbanDSLParser.new()
    sel = parser.parse("selected(A,B,C);done(D,E);deploy();")
    sel.should_not be_nil
    sel.stages[0].name.text_value.should eql('selected')
    sel.stages[1].name.text_value.should eql('done')
    sel.stages[0].body.cards.text_value.should eql('A,B,C')
    sel.stages[1].body.cards.text_value.should eql('D,E')
    parser.failure_reason.should be_nil
  end
  
  it "should render stage limits" do
    parser = KanbanDSLParser.new()
    sel = parser.parse("selected:2(A,B,C);done(D,E);deploy:10();")
    sel.should_not be_nil
    sel.stages[0].limit.should eql(2)
    sel.stages[1].limit.should be_nil
    sel.stages[2].limit.should eql(10)
  end

  it "should render substages" do
    parser = KanbanDSLParser.new()
    sel = parser.parse(
      "selected:2(A,B,C);" +
      "development[in progress(D,E,F)][done:2()];" +
      "deploy(G,H);")
    sel.should_not be_nil
    sel.stages[1].name.text_value.should eql('development')
    sel.stages[1].body.substages[0].name.text_value.should eql('in progress')
    sel.stages[1].body.substages[1].name.text_value.should eql('done')
    sel.stages[1].body.substages[1].limit.should eql(2)
    sel.stages[1].body.substages[0].cards.text_value.should eql('D,E,F')
  end

  it "should render a full complex kanban" do
    parser = KanbanDSLParser.new()
    sel = parser.parse(
      "selected:2(A,B,C);" +
      "development:5[in progress:2(D,E,F)][done(K)];" +
      "deploy(G,H);")
    sel.should_not be_nil
    parser.failure_reason.should be_nil
  end
end

def show(element, level)
  level.times {print '-'}  
  if element.text_value.length > 1
    puts element.text_value 
  end
  element.elements.each {|child| show(child, level = level + 1)} if element.elements
  level = level - 1
end

