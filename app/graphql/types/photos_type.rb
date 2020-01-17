module Types
  class PhotosType < BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :url, String, null: false
    field :thumbnailUrl, String, null: false
  end
end
