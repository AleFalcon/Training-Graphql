class PurchasedAlbumPolicy < ApplicationPolicy
  def create?
    unless PurchasedAlbum.where(user: user).count.zero?
      return { result: false, message: 'The user already bought this book' }
    end

    { result: true, message: nil }
  end
end
