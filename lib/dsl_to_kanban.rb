class DslToKanban
  attr_accessor :text
  def initialize(text)
    self.text = text
  end

  def parse
    kanban = Kanban.new
    text.each_line do |line|
      kanban.stages << Stage.new(*(line.match(/-(.*):?(\d+)?/).captures)) if stage?(line)
      kanban.stages[-1].cards << Card.new(line) if card?(line)
    end
    kanban
  end

  def card?(line)
    line.match(/^[^-](.+)/)
  end

  def stage?(line)
    line.match(/^-[^-](.+)/)
  end

  def substage?(line)
    line.match(/^--(.+)/)
  end
end