require "test_helper"

class SyncEpisodesJobTest < ActiveJob::TestCase
  setup do
    episodes_service_mock = Minitest::Mock.new

    page_one_result = [
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
    episodes_service_mock.expect(:get, [ page_one_result, false ], [ 1 ])

    page_two_result = [
      {
        id: 3,
        name: "name-3",
        air_date: Time.parse("2016-01-03 00:00:00"),
        code: "code-3",
        created_at: Time.parse("2026-01-03 00:00:00")
      }
    ]
    episodes_service_mock.expect(:get,  [ page_two_result, true ], [ 2 ])

    @expected = [ page_one_result, page_two_result ].flatten.sort_by { |record| record[:id] }

    @sync_episodes_job = SyncEpisodesJob.new(episode_service: episodes_service_mock)
  end

  test "success" do
    assert_difference("Episode.count", 3) do
      @sync_episodes_job.perform
      assert_equal 3, Episode.where(id: [ 1, 2, 3 ]).length
    end
  end
end
