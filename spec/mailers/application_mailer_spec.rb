require "rails_helper"

RSpec.describe ApplicationMailer do
  it { is_expected.to be_a(ActionMailer::Base) }

  describe "defaults" do
    it "has the expected values" do
      expect(described_class.default).to match(
        mime_version: "1.0",
        charset: "UTF-8",
        content_type: "text/plain",
        parts_order: [
          "text/plain",
          "text/enriched",
          "text/html",
        ],
        from: "from@example.com"
      )
    end
  end

  describe "layout" do
    it "is mailer" do
      expect(described_class._layout).to eq "mailer"
    end
  end
end
