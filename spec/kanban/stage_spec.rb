require 'spec_helper'

describe Stage do

  it "should add cards to stages" do
    stage(['A', 'B'], limit=2).cards.size.should eql(2)
  end

  it "should warn wip limit violations" do
    stage(['A', 'B']).wip_limit_violated?.should be_false
    stage(['A', 'B'], limit=2).wip_limit_violated?.should be_false
    stage(['A', 'B', 'C'], limit=2).wip_limit_violated?.should be_true
  end

  it "should add substages to stages" do
    Stage.new('development', limit=2).\
       add_substage('to do').\
       add_substage('done').\
       substages.size.should eql(2)
  end

  protected

  def stage(cards, limit=0)
    stage =  Stage.new('development', limit)
    cards.each {|card| stage.add_card card}
    return stage
  end

end
