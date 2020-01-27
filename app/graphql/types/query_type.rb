module Types
  class QueryType < Types::BaseObject
    ENDPOINT = 'https://jsonplaceholder.typicode.com/'.freeze

    field :albums, [AlbumType], null: false do
      description 'List all albums'
    end

    def albums
      albums = parse_albums(HTTParty.get("#{ENDPOINT}albums/"))
      add_photos_to_album(albums)
    end

    def add_photos_to_album(albums)
      albums.each do |elem|
        elem['photos'] = parse_photos(HTTParty.get("#{ENDPOINT}photos?albumId=#{elem['id']}"))
      end
      albums
    end

    def parse_albums(response)
      response.parsed_response.map { |x| x.transform_keys(&:underscore) }
    end

    def parse_photos(response)
      response.parsed_response.map { |x| x.transform_keys(&:underscore) }
    end
  end
end
