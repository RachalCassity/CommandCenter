module V1
  class MessagesController < ApplicationController
    def jsonapi_class
      { Message: SerializableMessage }
    end

    deserializable_resource :message, only: %i[create]

    def index
      messages = Message.all.order(created_at: :desc)
      render jsonapi: messages
    end

    def show
      message = Message.find(params[:id])
      render jsonapi: message
    end

    def create # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
      message = Message.new(create_params)

      if message.body.blank?
        # do not allow the other if statements to be called
      elsif message.body == "time?"
        message.reply = Time.zone.now
      elsif message.body.start_with?("calculate ")
        query = message.body.gsub(/\Acalculate /, "")
        message.reply = "https://www.wolframalpha.com/input/?i=" + CGI.escape(query)
      elsif message.body == "reverse expresso"
        message.reply = "wrong spelling"
      elsif message.body.start_with?("reverse ")
        message.reply = message.body.gsub(/\Areverse /, "").reverse
      end

      if message.save
        render jsonapi: message, status: :created
      else
        render jsonapi_errors: message.errors, status: :unprocessable_entity
      end
    end

    private

    def create_params
      params.require(:message).permit(:body)
    end
  end
end
