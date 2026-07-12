require "test_helper"

class SyncLocationsJobTest < ActiveJob::TestCase
  setup do
    location_service_mock = Minitest::Mock.new

    page_one_result = [
      {
        id: 1,
        name: "name-1",
        location_type: "type-1",
        dimension: "dimension-1",
        created_at: Time.parse("2026-01-01 00:00:00")
      },
      {
        id: 2,
        name: "name-2",
        location_type: "type-2",
        dimension: "dimension-2",
        created_at: Time.parse("2026-01-02 00:00:00")
      }
    ]
    location_service_mock.expect(:get, [ page_one_result, false ], [ 1 ])

    page_two_result = [
      {
        id: 3,
        name: "name-3",
        location_type: "type-3",
        dimension: "dimension-3",
        created_at: Time.parse("2026-01-03 00:00:00")
      }
    ]
    location_service_mock.expect(:get,  [ page_two_result, true ], [ 2 ])

    @expected = [ page_one_result, page_two_result ].flatten.sort_by { |record| record[:id] }

    @sync_location_job = SyncLocationsJob.new(location_service: location_service_mock)
  end

  test "success" do
    assert_difference("Location.count", 3) do
      @sync_location_job.perform
      assert_equal 3, Location.where(id: [ 1, 2, 3 ]).length
    end
  end
end
