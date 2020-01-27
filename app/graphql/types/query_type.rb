module Types
  class QueryType < Types::BaseObject
    ENDPOINT = 'https://jsonplaceholder.typicode.com/'.freeze

    field :album, AlbumType, null: false do
      argument :id, ID, required: true
    end

    def album(id:)
      album = parse_album(HTTParty.get("#{ENDPOINT}albums/#{id}"))
      album[:photos] = parse_photos(HTTParty.get("#{ENDPOINT}photos?albumId=#{id}"))
      album
    end

    def parse_album(response)
      response.parsed_response.transform_keys(&:underscore)
    end

    def parse_photos(response)
      response.parsed_response.map { |x| x.transform_keys(&:underscore) }
    end
  end
end
