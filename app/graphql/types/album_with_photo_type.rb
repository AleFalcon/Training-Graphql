module Types
  class AlbumWithPhotoType < BaseObject
    field :userId, ID, null: false
    field :id, Int, null: false
    field :title, String, null: false
    field :photos, [Types::PhotosType], null: false
  end
end
