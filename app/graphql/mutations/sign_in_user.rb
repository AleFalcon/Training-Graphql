module Mutations
  class SignInUser < BaseMutation
    null true

    argument :credentials, Types::AuthProviderCredentialsInput, required: false

    field :token, String, null: true

    def resolve(credentials: nil)
      user = User.find_by email: credentials[:email]
      return unless validations(credentials[:email], credentials[:password], user)

      token = generate_token(user)

      context[:session][:token] = token

      { token: token }
    end

    private

    def generate_token(user)
      crypt = ActiveSupport::MessageEncryptor.new(Rails.application
        .secrets[:secret_key_base].byteslice(0..31))
      crypt.encrypt_and_sign("user-id:#{user.id}")
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
