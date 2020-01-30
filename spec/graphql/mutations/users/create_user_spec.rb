require 'rails_helper'

module Mutations
  module Users
    RSpec.describe CreateUser, type: :request do
      describe '.resolve' do
        context 'when create a user' do
          let(:user) { build(:user) }

          before do
            user.email = user.first_name + '@wolox.com.ar'
            post '/graphql', params: { query: mutation_creation_user(first_name: user.first_name,
                                                                     last_name: user.last_name,
                                                                     email: user.email,
                                                                     password: user.password) }
          end

          it 'record creation' do
            expect(User.count).to eq(1)
          end

          it 'return the user first_name' do
            expect(User.last.first_name).to eql(user.first_name)
          end

          it 'return the user last_name' do
            expect(User.last.last_name).to eql(user.last_name)
          end

          it 'return the user email' do
            expect(User.last.email).to eql(user.email)
          end
        end

        context 'when dont create a user' do
          let(:user) { build(:user) }

          before do
            post '/graphql', params: { query: mutation_creation_user(first_name: user.first_name,
                                                                     last_name: user.last_name,
                                                                     email: user.email,
                                                                     password: user.password) }
          end

          it 'record creation' do
            expect(User.count).to eq(0)
          end

          it 'return the field data' do
            expect(JSON.parse(response.body)['data']).to eq(nil)
          end

          it 'return if exist field error' do
            expect(JSON.parse(response.body)['errors'].present?).to be true
          end

          it 'return the message of error' do
            expect(JSON.parse(response.body)['errors'][0]['message']).to eql(
              'Invalid input: email does not belong to wolox.com.ar'
            )
          end

          context 'when dont create a user' do
            let(:user) { build(:user) }

            before do
              user.email = user.first_name + '@wolox.com.ar'
              user.password = '123'
              post '/graphql', params: { query: mutation_creation_user(first_name: user.first_name,
                                                                       last_name: user.last_name,
                                                                       email: user.email,
                                                                       password: user.password) }
            end

            it 'record creation' do
              expect(User.count).to eq(0)
            end

            it 'return the field data' do
              expect(JSON.parse(response.body)['data']).to eq(nil)
            end

            it 'return if exist field error' do
              expect(JSON.parse(response.body)['errors'].present?).to be true
            end

            it 'return the message of error' do
              expect(JSON.parse(response.body)['errors'][0]['message']).to eql(
                'Invalid input: password very short'
              )
            end
          end
        end
      end
    end
  end
end
