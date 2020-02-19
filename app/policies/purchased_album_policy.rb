class PurchasedAlbumPolicy < ApplicationPolicy
  def create?
    PurchasedAlbum.where(user: user)
  end
end
