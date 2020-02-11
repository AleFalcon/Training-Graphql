module Mutations
  class SignInUser < BaseMutation
    null true

    argument :email, Types::AuthProviderEmailInput, required: false

    field :token, String, null: true
    field :user, Types::UserType, null: true

    def resolve(email: nil)
      user = User.find_by email: email[:email]
      return unless validations(email, user)

      crypt = ActiveSupport::MessageEncryptor.new(Rails.application
        .secrets[:secret_key_base].byteslice(0..31))
      token = crypt.encrypt_and_sign("user-id:#{user.id}")

      return unless context[:session][:token] != token

      context[:session][:token] = token
      { token: context[:session][:token] }
    end

    def valitadions(email, user)
      return unless validation_email(email)
      return unless user
      return unless user.authenticate(email[:password])
    end

    def validation_email(email)
      valid_email(email) && validation_wolox_domain(email)
    end

    def validation_wolox_domain(email)
      domain = '@wolox.com.ar'
      position = email =~ /#{domain}/
      return false if position.nil?

      email[position..(email.length)] == domain
    end

    def valid_email(email)
      email.split('@').count == 2
    end
  end
end
