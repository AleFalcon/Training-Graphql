module Types
  class QueryType < Types::BaseObject
    ENDPOINT = 'https://jsonplaceholder.typicode.com/'.freeze

    field :albums, [AlbumType], function: Resolvers::ListAlbums do
      description 'Filtered list of albums'
    end
  end
end
