class Stage
  attr_accessor :name, :limit, :substages, :cards
  
  def initialize(name, limit=0)
    @name = name.strip if name
    @limit = limit.to_i if limit
    @substages = []
    @cards = []
  end

  def add_card name
    @cards << name
    return self
  end
end
