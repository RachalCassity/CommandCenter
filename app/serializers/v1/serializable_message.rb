module V1
  class SerializableMessage < JSONAPI::Serializable::Resource
    type "messages"

    attributes :body, :reply

    attribute :received_at do
      @object.created_at
    end

    link :self do
      @url_helpers.v1_message_url(@object)
    end
  end
end
