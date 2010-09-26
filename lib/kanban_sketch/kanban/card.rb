class Card
  attr_accessor :name
  def initialize(name)
    @name = name.strip if name
  end
end