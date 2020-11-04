require "http/client"
require "./json"
require "./error"
require "./rsa"

module JWKS
  VERSION = "0.1.0"

  class Key
    property kid : String
    property alg : String?
    property public_key : String

    def initialize(@kid : String, @alg : String?, @public_key : String)
    end

    def self.from_response(key : KeyResponse)
      public_key = if key.has_cert
                     RSA.cert_to_pem key.get_x5c[0]
                   else
                     RSA.public_key_to_pem(key.n.as(String), key.e.as(String))
                   end
      self.new key.kid, key.alg, public_key
    end
  end

  def self.get_key(url, kid) : Key
    response = HTTP::Client.get url
    parsed = EndpointResponse.from_json response.body
    key = parsed.keys.find { |key| key.kid == kid }

    if key.nil?
      raise KeyNotFoundException.new
    end

    Key.from_response key.as(KeyResponse)
  end
end
