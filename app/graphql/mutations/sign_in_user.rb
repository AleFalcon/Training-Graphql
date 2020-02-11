module Mutations
  class SignInUser < BaseMutation
    null true

    argument :email, Types::AuthProviderEmailInput, required: false

    field :token, String, null: true
    field :user, Types::UserType, null: true

    def resolve(email: nil)
      user = User.find_by email: email[:email]
      return unless validations(email[:email], email[:password], user)

      token = generate_token(user)

      validation_token(context[:session][:token], token)
    end

    private

    def generate_token(user)
      crypt = ActiveSupport::MessageEncryptor.new(Rails.application
        .secrets[:secret_key_base].byteslice(0..31))
      crypt.encrypt_and_sign("user-id:#{user.id}")
    end

    def validation_token(session_token, token)
      return unless session_token != token

      { token: token }
    end

    def validations(email, password, user)
      return unless validation_email(email)
      return unless user
      return unless user.authenticate(password)

      true
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
