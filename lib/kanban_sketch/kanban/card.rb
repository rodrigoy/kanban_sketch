class Card
  attr_accessor :name
  def initialize(name)
    self.name = name.strip if name
  end
end