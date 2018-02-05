FactoryBot.define do
  factory :message do
    body { SecureRandom.urlsafe_base64 }
  end
end
