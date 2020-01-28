module Types
  class QueryType < Types::BaseObject
    ENDPOINT = 'https://jsonplaceholder.typicode.com/'.freeze

    field :albums, [AlbumType], null: false do
      description 'List all albums'
    end

    def albums
      AlbumsService.new(ENDPOINT).list_albums
    end
  end
end
