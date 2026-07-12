require "test_helper"

module RickAndMortyApi
  class LocationServiceTest < ActiveSupport::TestCase
    test "get" do
      payload = {
        "info": {
          "next": "not nill"
        },
        "results": [
          {
            "id": "id-1",
            "name": "name-1",
            "type": "type-1",
            "dimension": "dimension-1",
            "created": "2026-01-01 00:00:00"
          },
          {
            "id": "id-2",
            "name": "name-2",
            "type": "type-2",
            "dimension": "dimension-2",
            "created": "2026-01-02 00:00:00"
          }
        ]
      }

      Connection.api_connection = Faraday.new do |builder|
        builder.response :json

        builder.adapter :test do |stub|
          stub.get("/location") do |env|
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
          id: "id-1",
          name: "name-1",
          location_type: "type-1",
          dimension: "dimension-1",
          created_at: Time.parse("2026-01-01 00:00:00")
        },
        {
          id: "id-2",
          name: "name-2",
          location_type: "type-2",
          dimension: "dimension-2",
          created_at: Time.parse("2026-01-02 00:00:00")
        }
      ]

      actual_records, actual_is_last_page = LocationService.new.get
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
            "id": "id-3",
            "name": "name-3",
            "type": "type-3",
            "dimension": "dimension-3",
            "created": "2026-01-03 00:00:00"
          }
        ]
      }

      Connection.api_connection = Faraday.new do |builder|
        builder.response :json

        builder.adapter :test do |stub|
          stub.get("/location?page=2") do |env|
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
          id: "id-3",
          name: "name-3",
          location_type: "type-3",
          dimension: "dimension-3",
          created_at: Time.parse("2026-01-03 00:00:00")
        }
      ]

      actual_records, actual_is_last_page = LocationService.new.get 2
      assert_equal expected_records, actual_records
      assert_equal expected_is_last_page, actual_is_last_page
    end
  end
end
