require 'spec_helper'
require 'uri'

describe URLShortenerHelper do
  
  it "should short ids" do
    URLShortenerHelper.to_url_key(1304550).should eql('RYLI')
  end

  it "should return ids from url_keys" do
    URLShortenerHelper.to_kanban_id('RYLI').should eql(1304550)
  end

  it "should generate a valid URI" do
    (0..10000).each do |kanban_id|
      url_key = URLShortenerHelper.to_url_key(kanban_id)
      URI.parse("http://kanbansket.ch/#{url_key}")
      URLShortenerHelper.to_kanban_id(url_key).should eql(kanban_id)
    end
  end

end
