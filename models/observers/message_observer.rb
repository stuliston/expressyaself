require './models/message'

module ExpressYaSelf
  class MessageObserver < Mongoid::Observer
    def after_save(message)
      client = Faye::Client.new('http://192.168.1.109:1337/faye/faye')
      message.tags.each do |tag|
        client.publish('/messages/' + tag[1, tag.length], message.to_json)
      end
    end
  end
end
