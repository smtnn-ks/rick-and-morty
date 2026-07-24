module RickAndMortyApi
  class CharacterAvatarService
    CHARACTER_AVATAR_PATH = "character/avatar"

    def initialize
      @connection = Connection.api_connection
    end

    def get(character_id)
      @connection.get("#{CHARACTER_AVATAR_PATH}/#{character_id}.jpeg").body
    end
  end
end
