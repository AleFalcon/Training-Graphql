module Types
  class PurchasedAlbumType < BaseObject
    field :title, String, null: false
    field :user_id, UserType, null: true, method: :user
  end
end
