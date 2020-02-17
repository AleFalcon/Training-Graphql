module Mutations
  class BuyAlbum < BaseMutation

    type Types::PurchasedAlbumType

    def resolve(album_id: nil)
      #album = AlbumsService.new(ENDPOINT).get_album(album_id)
      album = { id: '1', title: 'quidem molestiae enim', user_id: '1' }
      purchase = create_hash_purchase(album, context[:current_user])
      byebug
      result = PurchasedAlbumPolicy.new(context[:current_user], purchase).create?
      unless result[:result]
        raise Pundit::NotAuthorizedError, "not allowed to create? this #{result[:message]}"
      end

      PurchasedAlbum.create!(user)
    end

    def create_hash_purchase(album, user_context)
      {
        album_id: album[:id],
        album_title: album[:title],
        user_id: user_context
      }
    end
  end
end
