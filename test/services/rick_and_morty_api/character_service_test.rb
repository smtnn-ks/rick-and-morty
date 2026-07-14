require "test_helper"

module RickAndMortyApi
  class CharacterServiceTest < ActiveSupport::TestCase
    test "get" do
      payload = {
        "info": {
          "next": "not nill"
        },
        "results": [
          {
            "id": 1,
            "name": "name-1",
            "status": "Alive",
            "species": "species-1",
            "type": "type-1",
            "gender": "Male",
            "origin": {
              "url": "https://rickandmortyapi.com/api/location/1"
            },
            "location": {
              "url": "https://rickandmortyapi.com/api/location/10"
            },
            "episode": [
              "https://rickandmortyapi.com/api/episode/1",
              "https://rickandmortyapi.com/api/episode/2"
            ],
            "created": "2026-01-01 00:00:00"
          },
          {
            "id": 2,
            "name": "name-2",
            "status": "Dead",
            "species": "species-2",
            "type": "type-2",
            "gender": "Female",
            "origin": {
              "url": "https://rickandmortyapi.com/api/location/2"
            },
            "location": {
              "url": "https://rickandmortyapi.com/api/location/20"
            },
            "episode": [
              "https://rickandmortyapi.com/api/episode/3",
              "https://rickandmortyapi.com/api/episode/4"
            ],
            "created": "2026-01-02 00:00:00"
          }
        ]
      }

      Connection.api_connection = Faraday.new do |builder|
        builder.response :json

        builder.adapter :test do |stub|
          stub.get("/character") do |env|
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
          status: "Alive",
          species: "species-1",
          character_type: "type-1",
          gender: "Male",
          origin_location_id: 1,
          location_id: 10,
          episode_ids: [ 1, 2 ],
          created_at: Time.parse("2026-01-01 00:00:00")
        },
        {
          id: 2,
          name: "name-2",
          status: "Dead",
          species: "species-2",
          character_type: "type-2",
          gender: "Female",
          origin_location_id: 2,
          location_id: 20,
          episode_ids: [ 3, 4 ],
          created_at: Time.parse("2026-01-02 00:00:00")
        }
      ]

      actual_records, actual_is_last_page = CharacterService.new.get
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
            "status": "unknown",
            "species": "species-3",
            "type": "type-3",
            "gender": "Genderless",
            "origin": {
              "url": "https://rickandmortyapi.com/api/location/3"
            },
            "location": {
              "url": "https://rickandmortyapi.com/api/location/30"
            },
            "episode": [
              "https://rickandmortyapi.com/api/episode/5"
            ],
            "created": "2026-01-03 00:00:00"
          }
        ]
      }

      Connection.api_connection = Faraday.new do |builder|
        builder.response :json

        builder.adapter :test do |stub|
          stub.get("/character?page=2") do |env|
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
          status: "unknown",
          species: "species-3",
          character_type: "type-3",
          gender: "Genderless",
          origin_location_id: 3,
          location_id: 30,
          episode_ids: [ 5 ],
          created_at: Time.parse("2026-01-03 00:00:00")
        }
      ]

      actual_records, actual_is_last_page = CharacterService.new.get 2
      assert_equal expected_records, actual_records
      assert_equal expected_is_last_page, actual_is_last_page
    end
  end
end
