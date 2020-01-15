require 'rails_helper'
require 'support/graphql/fixtures/graphql_album_helper'

module Mutations
  module Albums
    RSpec.describe AlbumSearch, type: :request do
      describe '.resolve' do
        context 'when get a album by id' do
          before do
            album_search_request_success
            post '/graphql', params: { query: mutation_get_album(albumId: '1') }
          end

          it 'return the id album' do
            expect(JSON.parse(response.body)['data']['albumId']['id']).to eq(1)
          end

          it 'return the title album' do
            expect(JSON.parse(response.body)['data']['albumId']['title'])
              .to eql('delectus aut autem')
          end
        end

        context 'when dont get a album by id' do
          before do
            album_search_request_not_found
            post '/graphql', params: { query: mutation_get_album(albumId: '10000000') }
          end

          it 'return the id album' do
            expect(JSON.parse(response.body)['data']).to eq(nil)
          end

          it 'return the title album' do
            expect(JSON.parse(response.body)['errors'].present?).to be true
          end
        end
      end
    end
  end
end