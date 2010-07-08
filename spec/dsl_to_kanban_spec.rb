require "spec_helper"

describe DSLToKanban do

  it 'should render simple stages' do
    dsl_text = 'selected(A,B,C);done(D,E);deploy();'
    kanban = DSLToKanban.render(dsl_text)
    kanban.stages[0].name.should eql('selected')
    kanban.stages[1].name.should eql('done')
    kanban.stages[0].cards[0].should eql('A')
  end

  it 'should render stage limits' do
    dsl_text = 'selected:2(A,B,C);done(D,E);deploy:10();'
    kanban = DSLToKanban.render(dsl_text)
    kanban.stages[0].limit.should eql(2)
    kanban.stages[1].limit.should eql(0)
    kanban.stages[2].limit.should eql(10)
  end

  it "should render substages" do
    dsl_text = 'selected:2(A,B,C);' +
      'development[in progress:2(D,E,F)][done()];' +
      'deploy(G,H);'
    kanban = DSLToKanban.render(dsl_text)
    kanban.stages[1].substages[0].name.should eql('in progress')
    kanban.stages[1].substages[0].limit.should eql(2)
    kanban.stages[1].substages[0].cards[1].should eql('E')
    kanban.stages[1].substages.size.should eql(2)
    
  end
end
