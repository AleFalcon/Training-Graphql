module Mutations
  class CreatePurchasedAlbum < BaseMutation
    argument :album_id, String, required: true

    type Types::PurchasedAlbumType

    def resolve(album_id: nil)
      purchase = create_purchased(album_id, context[:current_user])
      result = PurchasedAlbumPolicy.new(context[:current_user].id, purchase).create?
      unless result[:result]
        raise Pundit::NotAuthorizedError, "not allowed to create? this #{result[:message]}"
      end

      PurchasedAlbum.create!(purchase)

      { title: purchase[:album_title] }
    end

    def create_hash_purchase(album, user_context)
      {
        album_id: album['id'],
        album_title: album['title'],
        user_id: user_context
      }
    end

    def create_purchased(album_id, user_context)
      album = AlbumsService.new(ENDPOINT).get_album_without_photo(album_id)
      create_hash_purchase(album, user_context.id)
    end
  end
end
