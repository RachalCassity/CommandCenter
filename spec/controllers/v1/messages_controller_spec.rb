require "rails_helper"

module V1
  RSpec.describe MessagesController do
    describe "GET index" do
      it "returns messages" do
        create(:message)
        get :index
        expect(response).to have_http_status(:ok)
        expect(json_response["data"]).to be_an(Array)
      end
    end

    describe "GET show" do
      it "returns the message" do
        message = create(:message)
        get :show, params: { id: message.id }
        expect(response).to have_http_status(:ok)
        expect(json_response["data"]).to be_a(Hash)
      end
    end

    describe "POST create" do
      context "when you send a message body" do
        it "creates the message and responds with the message data" do
          payload = { _jsonapi: { data: { type: "messages", attributes: { body: "hi" } } } }

          post :create, params: payload

          expect(response).to have_http_status(:created)
          expect(json_response["data"]).to be_a(Hash)
          expect(json_response["data"]["attributes"]["body"]).to eq "hi"
          expect(json_response["data"]["attributes"]["reply"]).to be_nil
        end
      end

      context "when you send a message without a body (where it's blank)" do
        it "responds with an error" do
          payload = { _jsonapi: { data: { type: "messages", attributes: { body: "" } } } }

          post :create, params: payload

          expect(response).to have_http_status(:unprocessable_entity)
          expect(json_response["data"]).to be_nil
          expect(json_response["errors"]).to be_a(Array)
          expect(json_response["errors"].first["detail"]).to eq "Body can't be blank"
        end
      end
    end

    describe "commands" do
      context "when you send \"time?\" as the message body" do
        it "creates the message and responds with the message data" do
          payload = { _jsonapi: { data: { type: "messages", attributes: { body: "time?" } } } }

          post :create, params: payload

          expect(response).to have_http_status(:created)
          expect(json_response["data"]).to be_a(Hash)
          expect(json_response["data"]["attributes"]["body"]).to eq "time?"
          reply = Time.zone.parse(json_response["data"]["attributes"]["reply"])
          expect(reply).to be_within(10.seconds).of(Time.zone.now)
        end
      end
    end

    describe "reverse" do
      context "when you send \"reverse java\" as the message body" do
        it "replies \"avaj\"" do
          payload = { _jsonapi: { data: { type: "messages", attributes: { body: "reverse java" } } } }

          post :create, params: payload

          expect(response).to have_http_status(:created)
          expect(json_response["data"]).to be_a(Hash)
          expect(json_response["data"]["attributes"]["reply"]).to eq "avaj"
        end
      end

      context "when you send \"reverse cappuccino\" as the message body" do
        it "replies \"oniccuppac\"" do
          payload = { _jsonapi: { data: { type: "messages", attributes: { body: "reverse cappuccino" } } } }

          post :create, params: payload

          expect(response).to have_http_status(:created)
          expect(json_response["data"]).to be_a(Hash)
          expect(json_response["data"]["attributes"]["reply"]).to eq "oniccuppac"
        end
      end

      context "when you send \"reverse quadriple espresso\" as the message body" do
        it "replies \"osserpse elpirdauq\"" do
          payload = { _jsonapi: { data: { type: "messages", attributes: { body: "reverse quadriple espresso" } } } }

          post :create, params: payload

          expect(response).to have_http_status(:created)
          expect(json_response["data"]).to be_a(Hash)
          expect(json_response["data"]["attributes"]["reply"]).to eq "osserpse elpirdauq"
        end
      end

      context "when you send \"reverse expresso\" as the message body" do
        it "replies \"wrong spelling\"" do
          payload = { _jsonapi: { data: { type: "messages", attributes: { body: "reverse expresso" } } } }

          post :create, params: payload

          expect(response).to have_http_status(:created)
          expect(json_response["data"]).to be_a(Hash)
          expect(json_response["data"]["attributes"]["reply"]).to eq "wrong spelling"
        end
      end
    end

    describe "calculate" do
      context "when you send \"calculate 1+7\" as the message body" do
        it "replies \"https://www.wolframalpha.com/input/?i=1%2B7\"" do
          payload = { _jsonapi: { data: { type: "messages", attributes: { body: "calculate 1+7" } } } }

          post :create, params: payload

          expect(response).to have_http_status(:created)
          expect(json_response["data"]).to be_a(Hash)
          expect(json_response["data"]["attributes"]["reply"]).to eq "https://www.wolframalpha.com/input/?i=1%2B7"
        end
      end

      context "when you send \"calculate 1 + 7\" as the message body" do
        it "replies \"https://www.wolframalpha.com/input/?i=1+%2B+7\"" do
          payload = { _jsonapi: { data: { type: "messages", attributes: { body: "calculate 1 + 7" } } } }

          post :create, params: payload

          expect(response).to have_http_status(:created)
          expect(json_response["data"]).to be_a(Hash)
          expect(json_response["data"]["attributes"]["reply"]).to eq "https://www.wolframalpha.com/input/?i=1+%2B+7"
        end
      end
    end
  end
end
