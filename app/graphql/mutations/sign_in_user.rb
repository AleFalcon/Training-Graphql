module Mutations
  class SignInUser < BaseMutation
     null true

    argument :email, Types::AuthProviderEmailInput, required: false

    field :token, String, null: true
    field :user, Types::UserType, null: true

    def resolve(email: nil)
      # basic validation
      return unless email

      user = User.find_by email: email[:email]

      # ensures we have the correct user
      return unless user
      return unless user.authenticate(email[:password])

      # use Ruby on Rails - ActiveSupport::MessageEncryptor, to build a token
      crypt = ActiveSupport::MessageEncryptor.new(Rails.application.secrets[:secret_key_base].byteslice(0..31))
      token = crypt.encrypt_and_sign("user-id:#{user.id}")

      return unless context[:session][:token] != token
      context[:session][:token] = token
      { user: user, token: context[:session][:token] }
    end
  end
end