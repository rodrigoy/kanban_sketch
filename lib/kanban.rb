require "kanban/stage"
require "kanban/task"

class Kanban
  attr_accessor :stages
  def initialize
    self.stages = []
  end

  def self.parse(text)
    kanban = Kanban.new
    text.each_line do |line|
      stage_name, stage_limit = line.split(":")
      kanban.stages << Stage.new(stage_name, stage_limit)
    end
    kanban
  end
end