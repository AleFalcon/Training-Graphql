class PurchasedAlbum < ApplicationRecord
  belongs_to :user

  validates :album_id, presence: true
  validates :album_title, presence: true
end
