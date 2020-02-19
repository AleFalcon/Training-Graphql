require 'rails_helper'

module Mutations
  module Users
    RSpec.describe SignInUser, type: :request do
      describe '.resolve' do
        context 'when a user sign in' do
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

          it 'exist field token distinct nil' do
            expect(JSON.parse(response.body)['data']['signinUser']['token']).not_to be_nil
          end
        end

        context 'when a user not sign in' do
          let(:user) { build(:user) }

          before do
            post '/graphql', params: { query: mutation_sign_in(credentials: create_autho_provider(
              email: user.email.to_json, pass: user.password.to_json
            )) }
          end

          it 'exist field signinUser equal nil' do
            expect(JSON.parse(response.body)['data']['signinUser']).to be_nil
          end
        end
      end
    end
  end
end
