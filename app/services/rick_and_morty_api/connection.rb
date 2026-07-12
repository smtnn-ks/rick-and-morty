module RickAndMortyApi
  class Connection
    class << self
      URL = "https://rickandmortyapi.com/api"

      attr_writer :api_connection

      def api_connection
        @api_connection ||= default_connection
      end

      private

      def default_connection
        Faraday.new(URL) do |builder|
          builder.response :json
          builder.response :raise_error

          builder.options.timeout = 5
          builder.options.open_timeout = 5

          builder.response :logger, nil, { headers: false, bodies: false, errors: true }
        end
      end
    end
  end
end
