module Types
  class PhotoType < BaseObject
    field :id, ID, null: false
    field :album_id, ID, null: false
    field :title, String, null: false
    field :url, String, null: false
    field :thumbnail_url, String, null: false
  end
end
