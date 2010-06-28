require 'spec_helper'

describe KanbanToTable do
  
  it "should render stages" do
    kanban = Kanban.new
    kanban.add_stage("to do")
    kanban.add_stage("selected")
  end

end
