module Types
  class QueryType < Types::BaseObject
    field :albums, function: Resolvers::ListAlbums
  end
end
