require "rails_helper"

module V1
  RSpec.describe MessagesController do
    describe "collection" do
      let(:url) { "/v1/messages" }

      it { is_expected.to route(:get, url).to("v1/messages#index") }
      it { is_expected.to route(:post, url).to("v1/messages#create") }
    end

    describe "member" do
      let(:url) { "/v1/messages/#{params[:id]}" }
      let(:params) { { id: SecureRandom.uuid } }

      it { is_expected.to route(:get, url).to("v1/messages#show", id: params[:id]) }
      it { is_expected.not_to route(:put, url).to("v1/messages#update", id: params[:id]) }
      it { is_expected.not_to route(:patch, url).to("v1/messages#update", id: params[:id]) }
      it { is_expected.not_to route(:delete, url).to("v1/messages#destroy", id: params[:id]) }
    end
  end
end
