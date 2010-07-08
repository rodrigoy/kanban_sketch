require File.dirname(__FILE__) + '/substage'

class Stage
  attr_accessor :name, :limit, :substages, :cards
  
  def initialize(name, limit=0)
    @name = name.strip if name
    @limit = limit.to_i
    @substages = []
    @cards = []
  end

  def add_substage(name, limit=0)
    substage = SubStage.new(self, name, limit)
    @substages << substage
    return substage
  end

  def add_cards list
    list.split(',').each {|card| add_card card.strip}
  end  

  def add_card name
    @cards << name
    return self
  end

  def wip_limit_violated?
    @limit > 0 && (@cards.size > @limit || substages_cards.size > @limit)
  end

  def substages_cards
    @substages.collect {|substage| substage.cards}.flatten
  end

end
