module RickAndMortyApi
  class ImageService
    def initialize
      @connection = Connection.api_connection
    end

    def get(url)
      @connection.get(url).body
    end
  end
end
