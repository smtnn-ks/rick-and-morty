module RickAndMortyApi
  class EpisodeService
    EPISODE_PATH = "episode"

    def initialize
      @connection = Connection.api_connection
    end

    def get(page = nil)
      query_params = { "page": page } if page
      response = @connection.get(EPISODE_PATH, query_params)
      data = response.body

      episode_records = data.fetch("results").map { |data| map_episode(data) }
      is_last_page = data.fetch("info").fetch("next") == nil

      return episode_records, is_last_page
    end

    private

    def map_episode(data)
      {
        id: data["id"],
        name: data["name"],
        air_date: Time.parse(data["air_date"]),
        code: data["episode"],
        created_at: Time.parse(data["created"])
      }
    end
  end
end
