class PurchasedAlbumPolicy < ApplicationPolicy
  def create?
    byebug
    PurchasedAlbum.where(user: user)
  end
end
