require "test_helper"

module RickAndMortyApi
  class EpisodeServiceTest < ActiveSupport::TestCase
    test "get" do
      payload = {
        "info": {
          "next": "not nill"
        },
        "results": [
          {
            "id": 1,
            "name": "name-1",
            "air_date": "2016-01-01 00:00:00",
            "episode": "code-1",
            "created": "2026-01-01 00:00:00"
          },
          {
            "id": 2,
            "name": "name-2",
            "air_date": "2016-01-02 00:00:00",
            "episode": "code-2",
            "created": "2026-01-02 00:00:00"
          }
        ]
      }

      Connection.api_connection = Faraday.new do |builder|
        builder.response :json

        builder.adapter :test do |stub|
          stub.get("/episode") do |env|
            [
              200,
              { "Content-Type": "application/json" },
              payload.to_json
            ]
          end
        end
      end

      expected_is_last_page = false
      expected_records = [
        {
          id: 1,
          name: "name-1",
          air_date: Time.parse("2016-01-01 00:00:00"),
          code: "code-1",
          created_at: Time.parse("2026-01-01 00:00:00")
        },
        {
          id: 2,
          name: "name-2",
          air_date: Time.parse("2016-01-02 00:00:00"),
          code: "code-2",
          created_at: Time.parse("2026-01-02 00:00:00")
        }
      ]

      actual_records, actual_is_last_page = EpisodeService.new.get
      assert_equal expected_records, actual_records
      assert_equal expected_is_last_page, actual_is_last_page
    end

    test "get with page" do
      payload = {
        "info": {
          "next": nil
        },
        "results": [
          {
            "id": 3,
            "name": "name-3",
            "air_date": "2016-01-03 00:00:00",
            "episode": "code-3",
            "created": "2026-01-03 00:00:00"
          }
        ]
      }

      Connection.api_connection = Faraday.new do |builder|
        builder.response :json

        builder.adapter :test do |stub|
          stub.get("/episode?page=2") do |env|
            [
              200,
              { "Content-Type": "application/json" },
              payload.to_json
            ]
          end
        end
      end

      expected_is_last_page = true
      expected_records = [
        {
          id: 3,
          name: "name-3",
          air_date: Time.parse("2016-01-03 00:00:00"),
          code: "code-3",
          created_at: Time.parse("2026-01-03 00:00:00")
        }
      ]

      actual_records, actual_is_last_page = EpisodeService.new.get 2
      assert_equal expected_records, actual_records
      assert_equal expected_is_last_page, actual_is_last_page
    end
  end
end
