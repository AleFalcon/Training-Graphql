module Types
  class AlbumType < BaseObject
    field :userId, ID, null: false
    field :id, Int, null: false
    field :title, String, null: false
    field :completed, Boolean, null: false
    field :photos, [PhotoType], null: false
  end
end
