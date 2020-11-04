require "base64"

private def encode_size_hex(n)
  n_as_hex = UInt8.slice(n).hexstring
  if n < 127
    n_as_hex
  else
    size_of_size_byte = 128 + n_as_hex.size / 2
    UInt8.slice(n, size_of_size_byte).hexstring
  end
end

private def prepad_signed(str : String)
  msb = str.byte_at 0
  if msb < 0 || msb > 7
    %|00#{str}|
  else
    str
  end
end

module JWKS
  private module RSA
    def self.cert_to_pem(cert : String) : String
      padded = cert.split(//).in_groups_of(64).map(&.join).join("\n")
      %|-----BEGIN CERTIFICATE-----\n#{padded}\n-----END CERTIFICATE-----\n|
    end

    def self.public_key_to_pem(modulus_enc : String, exponent_enc : String) : String
      modulus = prepad_signed(Base64.decode(modulus_enc).hexstring)
      exponent = prepad_signed(Base64.decode(exponent_enc).hexstring)

      sizes = {modulus.size / 2, exponent.size / 2}
      enc_sizes = sizes.map { |s| encode_size_hex(s) }
      enc_keysize = encode_size_hex(2 + sizes[0] + sizes[1] + enc_sizes[0].size / 2 + enc_sizes[1].size / 2)

      public_key_hex = %|30#{enc_keysize}02#{enc_sizes[0]}#{modulus}02#{enc_sizes[1]}#{exponent}|

      %|-----BEGIN RSA PUBLIC KEY-----\n#{Base64.encode public_key_hex}-----END RSA PUBLIC KEY-----|
    end
  end
end
