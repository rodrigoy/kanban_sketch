require File.dirname(__FILE__) + '/substage'

class Stage
  attr_accessor :name, :limit, :substages, :cards
  
  def initialize(name, limit=0)
    @name = name.strip if name
    @limit = limit.to_i if limit
    @substages = []
    @cards = []
  end

  def add_substage(name, limit=0)
    @substages << SubStage.new(self, name, limit)
    return self
  end

  def add_card name
    @cards << name
    return self
  end

  def wip_limit_violated?
    @limit > 0 && (@cards.size > @limit || substages_cards.size > @limit)
  end

  def substages_cards
    @substages.each {|substage| cards << substage.cards}
  end

end
