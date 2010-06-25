require "kanban/stage"
require "kanban/substage"
require "kanban/task"
require "yaml"

class Kanban
  def self.parse(file)
    YAML.load_file(file)
  end
end