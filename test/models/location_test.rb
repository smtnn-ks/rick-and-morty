require "test_helper"

class LocationTest < ActiveSupport::TestCase
  setup do
    @location = locations(:location_one)
  end

  test "validation succeed" do
    assert @location.valid?
  end

  test "name is required" do
    @location.name = nil
    assert_not @location.valid?

    @location.name = ""
    assert_not @location.valid?
  end

  test "location_type is required" do
    @location.location_type = nil
    assert_not @location.valid?

    @location.location_type = ""
    assert_not @location.valid?
  end

  test "dimension is required" do
    @location.dimension = nil
    assert_not @location.valid?

    @location.dimension = ""
    assert_not @location.valid?
  end

  test "has origin characters" do
    assert_equal 1, @location.origin_characters.count
    assert_includes @location.origin_characters, characters(:character_one)
  end

  test "has characters" do
    assert_equal 1, @location.characters.count
    assert_includes @location.characters, characters(:character_two)
  end
end
