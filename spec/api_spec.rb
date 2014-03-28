# -*- coding:utf-8 -*-

require 'spec_helper'

describe OkuraWeb::API do
  include Rack::Test::Methods

  def app
    OkuraWeb::API
  end

  def post_json(uri, json)
    post uri, json, { "CONTENT_TYPE" => "application/json" }
  end

  describe OkuraWeb::API do
    describe "POST /okura/morph" do
      it "returns an empty array to empty input." do
        post_json('/okura/morph', "{}")
        expect(last_response.status).to eq 201
        expect(JSON.parse(last_response.body)).to eq []
      end

      it "returns an empty array to invalid input." do
        post_json '/okura/morph', '{"foo": "bar"}'
        expect(last_response.status).to eq 201
        expect(JSON.parse(last_response.body)).to eq []
      end

      it "returns correct results to valid input." do
        post_json '/okura/morph', '{"text": "こんにちは"}'
        expect(last_response.status).to eq 201
        expect(JSON.parse(last_response.body)).to eq(
          [{"surface" => "BOS/EOS",
            "text" => "[\"BOS/EOS\"]"},
           {"surface" => "こんにちは",
            "text" => "[\"感動詞\", \"*\", \"*\", \"*\", \"*\", \"*\", \"*\"]"},
           {"surface" => "BOS/EOS",
            "text" => "[\"BOS/EOS\"]"}])
      end
    end

    describe "POST /okura/wakati" do
      it "returns an empty array to empty input." do
        post_json('/okura/wakati', "{}")
        expect(last_response.status).to eq 201
        expect(JSON.parse(last_response.body)).to eq []
      end

      it "returns an empty array to invalid input." do
        post_json '/okura/wakati', '{"foo": "bar"}'
        expect(last_response.status).to eq 201
        expect(JSON.parse(last_response.body)).to eq []
      end

      it "returns correct results to valid input." do
        post_json '/okura/wakati', '{"text": "今日は晴れるでしょう。"}'
        expect(last_response.status).to eq 201
        expect(JSON.parse(last_response.body)).to eq(
          ["BOS/EOS", "今日", "は", "晴れる", "でしょ", "う", "。", "BOS/EOS"])
      end
    end
  end
end

# EOF
