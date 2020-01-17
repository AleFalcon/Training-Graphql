require 'rails_helper'
require 'support/graphql/fixtures/graphql_album_helper'

module Resolvers
  module Albums
    RSpec.describe ListAlbums, type: :request do
      describe '.resolve' do
        context 'when list all album' do
          before do
            filter_list_album_request_success
            post '/graphql', params: { query: query_filter_list_album(title: 'quidem') }
          end

          it 'return the count albums of list' do
            expect(JSON.parse(response.body)['data']['allAlbums'].count).to eq(2)
          end

          it 'return the title of first album' do
            expect(JSON.parse(response.body)['data']['allAlbums'][0]['title'])
              .to eql('quidem molestiae enim')
          end

          it 'return the id of first album' do
            expect(JSON.parse(response.body)['data']['allAlbums'][0]['id'])
              .to eq(1)
          end

          it 'return the title of last album' do
            expect(JSON.parse(response.body)['data']['allAlbums'][1]['title'])
              .to eql('ipsa quae voluptas natus ut suscipit soluta quia quidem')
          end

          it 'return the id of last album' do
            expect(JSON.parse(response.body)['data']['allAlbums'][1]['id'])
              .to eq(79)
          end
        end
      end
    end
  end
end
