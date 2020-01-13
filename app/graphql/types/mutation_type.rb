module Types
  class MutationType < Types::BaseObject
    field :signin_user, mutation: Mutations::SignInUser
    field :create_user, mutation: Mutations::CreateUser
  end
end
