class SubStage
  attr_accessor :name, :limit, :substages, :cards
  
  def initialize(stage, name, limit=0)
    @stage = stage    
    @name = name.strip if name
    @limit = limit.to_i if limit
    @cards = []
  end

  def add_cards list
    list.split(',').each {|card| add_card card.strip}
  end  

  def add_card name
    @cards << name
    return self
  end

  def wip_limit_violated?
    @limit.to_i > 0 && @cards.size > @limit
  end
end
