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
