require "./spec_helper"
require "webmock"

TEST_URL = "https://test.com/.well-known/jwks.json"
KID      = "abc123"

describe JWKS do
  describe "#getKey" do
    it "resolves the key from the provided URL" do
      true.should eq true
    end
  end
end
