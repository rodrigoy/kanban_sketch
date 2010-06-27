class Stage
  attr_accessor :name, :limit, :substages, :cards
  def initialize(name, limit)
    self.name = name
    self.limit = limit
    self.substages = []
    self.cards = []
  end
end