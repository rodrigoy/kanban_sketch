require 'spec_helper'

describe KanbanToTable do
  
  it "should render simple stages" do
    KanbanToTable.render(simple_kanban).th.td[1].p2.should eql('development')
  end

  it "should render stage limits" do
    deploy = KanbanToTable.render(limited_kanban).th.td[2]
    deploy.p1.should eql(3)
    deploy.p2.should eql('deployment')
  end

  it "should render stage stories" do
    table = KanbanToTable.render(simple_kanban_with_stories)
    table.tr.td[0][0].should eql('A')
    table.tr.td[0][1].should eql('B')
    table.tr.td[1][0].should eql('C')
    table.tr.td[2][0].should eql('E')
  end

  protected

  def simple_kanban
    kanban = Kanban.new
    kanban.add_stage('selected')
    kanban.add_stage('development')
  end

  def limited_kanban
    simple_kanban.add_stage('deployment', limit=3)
  end

  def simple_kanban_with_stories
    kanban = limited_kanban    
    kanban.stages[0].add_card('A').add_card('B')
    kanban.stages[1].add_card('C')
    kanban.stages[2].add_card('E')
    return kanban
  end

end
