require 'uri'
require 'mongo'

class KanbanStore
  
  uri = URI.parse(ENV['MONGOHQ_URL'])
  conn = Mongo::Connection.new(uri.host, uri.port)
  db = conn.db(uri.path.gsub(/^\//, ''))
  @collection = db.collection('kanbans')

  def self.save!(dsl_text)
      document = @collection.find_one({'dsl_text' => dsl_text})
      if !document
        @collection.insert({
          '_id' => next_id,
          'dsl_text' => dsl_text
         })
      else
        document['_id']
      end
  end
  
  def self.find(_id)
    @collection.find_one({'_id'=> _id})
  end

  def self.delete_all
    @collection.drop
  end

  protected

  def self.next_id
    cursor = @collection.find().sort(['_id', 'descending']).limit(1)
    next_id = cursor.has_next? ? cursor.next_document['_id'] + 1 : 1
  end

end
