require "test_helper"

class EpisodeTest < ActiveSupport::TestCase
  setup do
    @episode = episodes(:episode_one)
  end

  test "validation succeed" do
    assert @episode.valid?
  end

  test "name is required" do
    @episode.name = nil
    assert_not @episode.valid?

    @episode.name = ""
    assert_not @episode.valid?
  end

  test "air_date is required" do
    @episode.air_date = nil
    assert_not @episode.valid?

    @episode.air_date = ""
    assert_not @episode.valid?
  end

  test "code is required" do
    @episode.code = nil
    assert_not @episode.valid?

    @episode.code = ""
    assert_not @episode.valid?
  end

  test "has characters" do
    assert_equal 2, @episode.characters.count
    assert_includes @episode.characters, characters(:character_one)
    assert_includes @episode.characters, characters(:character_two)
   end
end
