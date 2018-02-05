require "rails_helper"

module V1
  RSpec.describe SerializableMessage do
    subject(:result) { jsonapi_serialize(obj, Message: described_class) }

    let(:obj) { create(:message) }

    describe "type" do
      it "has the expected type" do
        expect(result[:data][:type]).to eq :messages
      end
    end

    describe "attributes" do
      it "has the expected attributes" do
        expect(result[:data][:attributes].keys).to eq %i[body reply received_at]
      end
    end

    describe "links" do
      it "has the self link" do
        expect(result[:data][:links][:self]).to eq v1_message_url(obj)
      end
    end
  end
end
