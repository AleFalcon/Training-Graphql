module Types
  class QueryType < Types::BaseObject
    ENDPOINT = 'https://jsonplaceholder.typicode.com/'.freeze

    field :albums, [AlbumType], function: Resolvers::ListAlbums do
      description 'Filtered list of albums'
    end

    field :album, AlbumType, null: false do
      argument :id, ID, required: true
    end

    def album(id:)
      AlbumsService.new(ENDPOINT).get_album(id)
    end
  end
end
