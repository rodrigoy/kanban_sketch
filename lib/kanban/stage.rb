class Stage
  attr_accessor :name, :limit, :substages, :cards
  def initialize(name, limit=0)
    self.name = name.strip if name
    self.limit = limit.to_i if limit
    self.substages = []
    self.cards = []
  end
end
