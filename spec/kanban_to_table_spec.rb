require 'spec_helper'

describe KanbanToTable do
  
  it "should render simple stages" do
    KanbanToTable.render(simple_kanban).th[1].p2.should eql('development')
  end

  it "should render stage limits" do
    deploy = KanbanToTable.render(limited_kanban).th[2]
    deploy.p1.should eql(3)
    deploy.p2.should eql('deployment')
  end

  it "should render stage stories" do
    table = KanbanToTable.render(simple_kanban_with_stories)
    table.td[0][0].should eql('A')
    table.td[0][1].should eql('B')
    table.td[1][0].should eql('C')
    table.td[2][0].should eql('E')
  end
    
  it "should warn wip limit violations" do
    kanban = KanbanToTable.render(simple_kanban_with_wip_limit_violation)
    kanban.th[0].violated.should be_false
    kanban.th[2].violated.should be_true
  end

  it "should render substages" do
    kanban = KanbanToTable.render(kanban_with_substages)
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

  def simple_kanban_with_wip_limit_violation
    kanban = simple_kanban_with_stories
    kanban.stages[2].add_card('F').add_card('G').add_card('H')
    return kanban
  end

  def kanban_with_substages
    kanban = Kanban.new
    kanban.add_stage('selected').
      stages[0].add_card('A')

    kanban.add_stage('development').
      stages[1].
        add_substage('in progress').
        add_substage('done').
          substages[1].
            add_card('B').
            add_card('C')

    kanban.add_stage('deployment')
 
    return kanban
  end

end
