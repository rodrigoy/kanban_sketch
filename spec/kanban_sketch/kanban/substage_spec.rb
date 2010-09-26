require 'spec_helper'

describe SubStage do

  it "should add cards" do
    substage(['A', 'B'], limit=2).cards.size.should eql(2)
  end

  it "should batch add cards to substages" do
    substage = SubStage.new(Stage.new('development'), 'in progress')
    substage.add_cards('A, B, C');
    substage.cards[0].should eql('A')
    substage.cards[2].should eql('C')
  end

  it "should warn wip limit violations" do
    substage(['A', 'B']).wip_limit_violated?.should be_false
    substage(['A', 'B'], limit=2).wip_limit_violated?.should be_false
    substage(['A', 'B', 'C'], limit=2).wip_limit_violated?.should be_true
  end
  
  protected

  def substage(cards, limit=0, stage_limit=0)
    stage = Stage.new('development', stage_limit)
    stage.add_substage('to do', limit)
    cards.each {|card| stage.substages[0].add_card(card)}
    return stage.substages[0]
  end

end
