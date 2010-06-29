require 'spec_helper'

describe Stage do

  it "should add cards to stages" do
    Stage.new('to do').\
      add_card('A').\
      add_card('B').\
        cards.size.should eql(2)
  end

  it "should warn wip limit violations" do
    subject = Stage.new('to do', limit=2)
    subject.\
      add_card('A').\
      add_card('B').\
        wip_limit_violated?.should be_false
    
    subject.\
      add_card('C').\
        wip_limit_violated?.should be_true
  end

  it "should add substages to stages" do
    Stage.new('development', limit=2).\
       add_substage('to do').\
       add_substage('done').\
       substages.size.should eql(2)
  end

end
