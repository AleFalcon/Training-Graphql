module Types
  class AlbumType < BaseObject
    field :userid, ID, null: false
    field :id, Int, null: false
    field :title, String, null: false
  end
end
