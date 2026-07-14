require "test_helper"

class SyncCharactersJobTest < ActiveJob::TestCase
  setup do
    character_service_mock = Minitest::Mock.new

    page_one_result = [
      {
        id: 1,
        name: "name-1",
        status: "Alive",
        species: "species-1",
        character_type: "type-1",
        gender: "Male",
        origin_location_id: locations(:location_one).id,
        location_id: locations(:location_two).id,
        episode_ids: [ episodes(:episode_one).id, episodes(:episode_two).id ],
        created_at: Time.parse("2026-01-01 00:00:00")
      },
      {
        id: 2,
        name: "name-2",
        status: "Dead",
        species: "species-2",
        character_type: "type-2",
        gender: "Female",
        origin_location_id: locations(:location_one).id,
        location_id: locations(:location_one).id,
        episode_ids: [ episodes(:episode_one).id ],
        created_at: Time.parse("2026-01-02 00:00:00")
      }
    ]
    character_service_mock.expect(:get, [ page_one_result, false ], [ 1 ])

    page_two_result = [
      {
        id: 3,
        name: "name-3",
        status: "unknown",
        species: "species-3",
        character_type: "type-3",
        gender: "Genderless",
        origin_location_id: locations(:location_two).id,
        location_id: locations(:location_two).id,
        episode_ids: [ episodes(:episode_two).id ],
        created_at: Time.parse("2026-01-03 00:00:00")
      }
    ]
    character_service_mock.expect(:get,  [ page_two_result, true ], [ 2 ])

    @expected = [ page_one_result, page_two_result ].flatten.sort_by { |record| record[:id] }

    @sync_characters_job = SyncCharactersJob.new(character_service: character_service_mock)
  end

  test "success" do
    assert_difference("Character.count", 3) do
      @sync_characters_job.perform
      assert_equal 3, Character.where(id: [ 1, 2, 3 ]).length
    end
  end
end
