def mutation_creation_user(first_name:, last_name:, email:, password:)
  <<~GQL
    mutation{
      createUser(firstName:"#{first_name}", lastName:"#{last_name}", email:"#{email}", password:"#{password}")
      {
        id
        firstName
        lastName
        email
      }
    }
  GQL
end

def mutation_sign_in(email:)
  <<~GQL
    mutation {
      signinUser(
        email: #{email}
        ) {
          token
          user {
            id
          }
        }
      }
  GQL
end

def create_autho_provider(email:, pass:)
  <<~GQL
    {
      email: #{email},
      password: #{pass}
    }
  GQL
end
