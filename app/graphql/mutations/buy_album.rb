module Mutations
  class BuyAlbum < BaseMutation

    field :album_id, String, null: true

    type Types::PurchasedAlbumType

    def resolve(album_id: nil)
      user = create_hash_user(first_name, last_name, email, password)
      result = UserPolicy.new(nil, user).create?
      unless result[:result]
        raise Pundit::NotAuthorizedError, "not allowed to create? this #{result[:message]}"
      end

      User.create!(user)
    end
  end
end