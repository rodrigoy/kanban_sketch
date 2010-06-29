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
    substage = SubStage.new(self, name, limit)
    @substages << substage
    return self
  end

  def add_card name
    @cards << name
    return self
  end

  def wip_limit_violated?
    @limit > 0 && @cards.size > @limit
  end
end
