module Mutations
  class CreateUser < BaseMutation
    argument :first_name, String, required: true
    argument :last_name, String, required: true
    argument :email, String, required: true
    argument :password, String, required: true

    type Types::UserType

    def resolve(first_name: nil, last_name: nil, email: nil, password: nil)
      user = create_hash_user(first_name, last_name, email, password)
      result = UserPolicy.new(nil, user).create?
      if result[:result]
        User.create!(user)
      else
        GraphQL::ExecutionError.new("Invalid input: #{result[:message]}")
      end
    end

    def create_hash_user(first_name, last_name, email, password)
      {
        first_name: first_name,
        last_name: last_name,
        email: email,
        password: password
      }
    end
  end
end
