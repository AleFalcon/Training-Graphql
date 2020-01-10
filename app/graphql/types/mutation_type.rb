module Types
  class MutationType < Types::BaseObject
    field :album_id, mutation: Mutations::AlbumSearch
  end
end
