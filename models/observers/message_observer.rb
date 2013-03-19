require 'haml'

module ExpressYaself
  class MessageObserver < Mongoid::Observer
    def after_save(message)
      @client ||= Faye::Client.new("http://localhost:#{ExpressYaself::App.port}/faye/faye")
      presenter = MessagePresenter.new(message)
      message.tags.each do |tag|
        @client.publish(queue_for_tag(tag), presenter.html_for_message)
      end
    end

    private
      def queue_for_tag(tag)
        '/messages/' + strip_leading(tag)
      end

      def strip_leading(tag)
        tag[1, tag.length]
      end
  end
end
