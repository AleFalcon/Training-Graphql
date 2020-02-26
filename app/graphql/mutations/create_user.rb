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
      unless result[:result]
        raise Pundit::NotAuthorizedError, I18n.t('error.creation', message: result[:message]), result[:reason]
      end

      User.create!(user)
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
