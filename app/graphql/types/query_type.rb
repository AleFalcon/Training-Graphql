module Types
  class QueryType < Types::BaseObject
    field :all_albums, function: Resolvers::ListAllAlbums
  end
end
