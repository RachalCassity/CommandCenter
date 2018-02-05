def json_response
  JSON.parse(response.body)
end

def jsonapi_serialize(obj, klass_options, options = {})
  renderer = JSONAPI::Serializable::Renderer.new
  render_options = {
    class: klass_options,
    expose: JSONAPI::Rails.config.jsonapi_expose.call,
  }.merge(options)
  renderer.render(obj, render_options)
end
