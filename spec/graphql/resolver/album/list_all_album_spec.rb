require 'rails_helper'
require 'support/graphql/fixtures/graphql_album_helper'

module Resolvers
  module Albums
    RSpec.describe ListAllAlbums, type: :request do
      describe '.resolve' do
        context 'when list all album' do
          before do
            list_all_album_request_success
            post '/graphql', params: { query: mutation_list_album }
          end

          it 'return the count albums of list' do
            expect(JSON.parse(response.body)['data']['allAlbums'].count).to eq(100)
          end

          it 'return the title of first album' do
            expect(JSON.parse(response.body)['data']['allAlbums'][0]['title'])
              .to eql('quidem molestiae enim')
          end

          it 'return the id of first album' do
            expect(JSON.parse(response.body)['data']['allAlbums'][0]['id'])
              .to eq(1)
          end
        end
      end
    end
  end
end
