
Dir['models/*.rb'].each do |model|
  require model
end

set :views, File.join(File.dirname(__FILE__), 'views')

require 'helpers/url_shortener_helper'