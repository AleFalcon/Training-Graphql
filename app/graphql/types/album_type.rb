module Types
  class AlbumType < BaseObject
    field :id, ID, null: false
    field :user_id, ID, null: false
    field :title, String, null: false
  end
end
