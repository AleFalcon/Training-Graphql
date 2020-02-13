module Types
  class QueryType < Types::BaseObject
    ENDPOINT = 'https://jsonplaceholder.typicode.com/'.freeze

    field :album, AlbumType, null: false do
      argument :id, ID, required: true
    end

    field :albums, [AlbumType], function: Types::ListAlbums do
      description 'List all albums'
    end

    def album(id:)
      AlbumsService.new(ENDPOINT).get_album(id)
    end
  end
end
