require "rails_helper"

RSpec.describe Message do
  subject { build(:message) }

  describe "columns" do
    it { is_expected.to have_db_column(:body).of_type(:text).with_options(null: false) }
    it { is_expected.to have_db_column(:reply).of_type(:text) }
  end

  describe "validations" do
    it do
      is_expected.to validate_presence_of(:body)
    end
  end
end
