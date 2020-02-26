class PurchasedAlbumPolicy < ApplicationPolicy
  def create?
    unless PurchasedAlbum.where(user: user, album_id: record[:album_id]).count.zero?
      return { result: false,
        message: I18n.t('pundit.error.creation.purchased_book', album_id: record[:album_id])
        }
    end

    { result: true, message: nil}
  end
end
