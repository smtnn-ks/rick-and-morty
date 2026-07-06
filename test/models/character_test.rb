require "test_helper"

class CharacterTest < ActiveSupport::TestCase
  setup do
    @character = characters(:character_one)
  end

  test "validation succeed" do
    assert @character.valid?
  end

  test "name is required" do
    @character.name = nil
    assert_not @character.valid?

    @character.name = ""
    assert_not @character.valid?
  end

  test "species is required" do
    @character.species = nil
    assert_not @character.valid?

    @character.species = ""
    assert_not @character.valid?
  end

  test "character_type is required" do
    @character.character_type = nil
    assert_not @character.valid?

    @character.character_type = ""
    assert_not @character.valid?
  end

  test "status is a valid enum" do
    @character.status = "Alive"
    @character.status = "Dead"
    @character.status = "unknown"

    assert_raises ArgumentError do
      @character.status = "nonexisting status"
    end
  end

  test "gender is a valid enum" do
    @character.gender = "Male"
    @character.gender = "Female"
    @character.gender = "Genderless"
    @character.gender = "Other"

    assert_raises ArgumentError do
      @character.gender = "nonexisting gender"
    end
  end

  test "has origin location" do
    assert_equal locations(:location_one), @character.origin_location
  end

  test "has location" do
    assert_equal locations(:location_two), @character.location
  end

  test "has episodes" do
    assert_equal 2, @character.episodes.count
    assert_includes @character.episodes, episodes(:episode_one)
    assert_includes @character.episodes, episodes(:episode_two)
  end
end
