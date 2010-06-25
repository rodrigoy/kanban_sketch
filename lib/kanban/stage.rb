class Stage
  attr_accessor :name, :limit, :substages, :tasks
  def initialize(name, limit)
    self.name = name
    self.limit = limit
    self.substages = []
    self.tasks = []
  end
end