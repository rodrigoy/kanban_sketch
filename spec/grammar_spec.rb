require 'treetop'
require File.dirname(__FILE__) + '/../lib/grammar'

describe KanbanDSL do

  it "should render simple stages with limits" do
    parser = KanbanDSLParser.new()
    sel = parser.parse("
       to do=A,B;
       in progress:3=G,H,I;
       waiting;
      ")
    parser.failure_reason.should be_nil
    sel.should_not be_nil
    sel.stages[0].name.should eql('to do')
    sel.stages[0].limit.should be_nil
    sel.stages[1].limit.should eql(3)
    sel.stages[1].cards.should eql('G,H,I')
    sel.stages[2].name.should eql('waiting')
  end
  
  it "should render substages with limits" do
    parser = KanbanDSLParser.new()
    sel = parser.parse("
      selected:2=A,B;
      development:5;
        -in progress:3=C,D,E;
        -done=F,G;
      to deploy=H,I;
      in production=J,K,L,M,N,O,P;
    ")
    parser.failure_reason.should be_nil
    sel.should_not be_nil
    
    sel.stages[0].name.should eql('selected')
    sel.stages[0].limit.should eql(2)
    sel.stages[0].substage?.should be_false
    
    sel.stages[1].name.should eql('development')
    sel.stages[1].limit.should eql(5)
    
    sel.stages[2].name.should eql('in progress')
    sel.stages[2].limit.should eql(3)
    sel.stages[2].cards.should eql('C,D,E')
    sel.stages[2].substage?.should be_true
    
    sel.stages[5].name.should eql('in production')
    sel.stages[5].cards.should eql('J,K,L,M,N,O,P')
  end
end


