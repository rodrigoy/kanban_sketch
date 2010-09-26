require 'spec_helper'

describe KanbanToTable do
  
  it "should render simple stages" do
    KanbanToTable.render(simple_kanban).th1[1].p2.should eql('development')
  end

  it "should render stage limits" do
    deploy = KanbanToTable.render(limited_kanban).th1[2]
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
    kanban.th1[0].violated.should be_false
    kanban.th1[2].violated.should be_true
  end

  it "should render substages" do
    kanban = KanbanToTable.render(kanban_with_substages)
    kanban.th1[0].p2.should eql('selected')
    kanban.th1[0].colspan.should eql(1)
    kanban.th1[0].rowspan.should eql(2)
    kanban.th1[1].p2.should eql('development')
    kanban.th1[1].colspan.should eql(3)
    kanban.th1[1].rowspan.should eql(1)
      kanban.th2[0].p2.should eql('acceptance')
      kanban.th2[1].p2.should eql('in progress')
      kanban.th2[2].p2.should eql('done')
    kanban.th1[2].p2.should eql('deployment')
    kanban.th1[2].colspan.should eql(2)
    kanban.th1[2].rowspan.should eql(1)
      kanban.th2[3].p2.should eql('in progress')
      kanban.th2[4].p2.should eql('done')
    kanban.td[0].size.should eql(1)
    kanban.td[1].size.should eql(0)
    kanban.td[2].size.should eql(0)
    kanban.td[3].size.should eql(2)
    kanban.td[4].size.should eql(0)
    kanban.td[5].size.should eql(2)
  end

  protected

  def simple_kanban
    kanban = Kanban.new
    kanban.add_stage('selected')
    kanban.add_stage('development')
    return kanban
  end

  def limited_kanban
    kanban = simple_kanban
    kanban.add_stage('deployment', limit=3)
    return kanban
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
    kanban.add_stage('selected').add_card('A')

    stage = kanban.add_stage('development')
    stage.add_substage('acceptance')
    stage.add_substage('in progress')
    stage.add_substage('done').
            add_card('B').
            add_card('C')

    stage = kanban.add_stage('deployment')
    stage.add_substage('in progress')
    stage.add_substage('done').
            add_card('D').
            add_card('E') 
    return kanban
  end

end
