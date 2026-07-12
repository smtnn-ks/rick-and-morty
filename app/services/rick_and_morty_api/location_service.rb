module RickAndMortyApi
  class LocationService
    LOCATION_PATH = "location"

    def initialize
      @connection = Connection.api_connection
    end

    def get(page = nil)
      query_params = { "page": page } if page
      response = @connection.get(LOCATION_PATH, query_params)
      data = response.body

      location_records = data.fetch("results").map { |data| map_location(data) }
      is_last_page = data.fetch("info").fetch("next") == nil

      return location_records, is_last_page
    end

    private

    def map_location(data)
      {
        id: data.fetch("id"),
        name: data.fetch("name"),
        location_type: data.fetch("type"),
        dimension: data.fetch("dimension"),
        created_at: Time.parse(data.fetch("created"))
      }
    end
  end
end
