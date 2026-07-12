class SyncLocationsJob < ApplicationJob
  queue_as :default

  def initialize(location_service: RickAndMortyApi::LocationService.new)
    @location_service = location_service
  end

  def perform
    page = 1
    loop do
      records, is_last_page = @location_service.get page
      Location.upsert_all records
      break if is_last_page
      page += 1
    end
  end
end
