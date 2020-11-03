require "json"
require "./error"

private macro string_fields_optional(*names)
  {% for name, index in names %}
    @[JSON::Field(key: {{name}})]
    property {{name}} : String?
  {% end %}
end

module JWKS
  class KeyResponse
    include JSON::Serializable
    string_fields_optional alg, kty, use, n, e, x5t

    @[JSON::Field(key: "kid")]
    property kid : String

    @[JSON::Field(key: "x5c")]
    property x5c : Array(String)?

    def has_cert
      !@x5c.nil? && @x5c.as(Array(String)).size > 0
    end

    def get_x5c
      if @x5c.nil?
        raise KeyResponsePropertyNotFoundException.new "x5c property on KeyResponse JSON not found"
      else
        @x5c.as(Array(String))
      end
    end
  end

  class EndpointResponse
    include JSON::Serializable

    @[JSON::Field(key: "keys")]
    property keys : Array(KeyResponse)
  end
end
