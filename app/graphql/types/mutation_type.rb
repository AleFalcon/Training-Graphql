module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::CreateUser
    field :signin_user, mutation: Mutations::SignInUser
    field :buy_album, mutation: Mutations::BuyAlbum do
      argument :album_id, ID, required: true
    end
  end
end
