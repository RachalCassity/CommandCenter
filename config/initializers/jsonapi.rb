JSONAPI::Rails.configure do |config|
  config.logger = Logger.new("/dev/null")

  config.jsonapi_object = nil
end
