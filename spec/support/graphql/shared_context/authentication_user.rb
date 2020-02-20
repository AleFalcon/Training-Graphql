RSpec.shared_context 'with Authentication User', shared_context: :metadata do
  let(:user) { build(:user) }
  before do
    user.email = user.first_name + '@wolox.com.ar'
    post '/graphql', params: { query: mutation_creation_user(first_name: user.first_name,
                                                             last_name: user.last_name,
                                                             email: user.email,
                                                             password: user.password) }
    post '/graphql', params: { query: mutation_sign_in(credentials: create_autho_provider(
      email: user.email.to_json, pass: user.password.to_json
    )) }
  end
end
