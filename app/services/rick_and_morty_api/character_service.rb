module RickAndMortyApi
  class CharacterService
    CHARACTER_PATH = "character"

    def initialize
      @connection = Connection.api_connection
    end

    def get(page = nil)
      query_params = { "page": page } if page
      response = @connection.get(CHARACTER_PATH, query_params)
      data = response.body

      character_records = data.fetch("results").map { |data| map_character(data) }
      is_last_page = data.fetch("info").fetch("next") == nil

      return character_records, is_last_page
    end

    private

    def extract_id_from_url(url)
      url&.split("/")&.last&.to_i
    end

    def map_character(data)
      {
        id: data.fetch("id"),
        name: data.fetch("name"),
        status: data.fetch("status"),
        species: data.fetch("species"),
        gender: data.fetch("gender"),

        character_type: begin
          type = data.fetch("type")
          type unless type.empty?
        end,

        origin_location_id: extract_id_from_url(data.fetch("origin").fetch("url")),
        location_id: extract_id_from_url(data.fetch("location").fetch("url")),

        episode_ids: data.fetch("episode").map { |episode_url| extract_id_from_url(episode_url) },

        created_at: Time.parse(data.fetch("created"))
      }
    end
  end
end
