require 'rails_helper'

module Types
  module Albums
    RSpec.describe QueryType, type: :request do
      describe '.resolve' do
        context 'when get a album by id' do
          before do
            album_search_request_success
            photos_for_album_success
            post '/graphql', params: { query: query_get_album(id: '1') }
          end

          it 'return the id album' do
            expect(JSON.parse(response.body)['data']['album']['id']).to eql('1')
          end

          it 'return the title album' do
            expect(JSON.parse(response.body)['data']['album']['title'])
              .to eql('delectus aut autem')
          end

          it 'return the userId album' do
            expect(JSON.parse(response.body)['data']['album']['userId'])
              .to eql('1')
          end

          it 'return the count of photos' do
            expect(JSON.parse(response.body)['data']['album']['photos'].count)
              .to eq(50)
          end

          it 'return the first photos' do
            (expect(JSON.parse(response.body)['data']['album']['photos'].first['id'])
              .to eql('1')) &&
              (expect(JSON.parse(response.body)['data']['album']['photos'].first['title'])
                .to eql('accusamus beatae ad facilis cum similique qui sunt')) &&
              (expect(JSON.parse(response.body)['data']['album']['photos'].first['url'])
                .to eql('https://via.placeholder.com/600/92c952')) &&
              (expect(JSON.parse(response.body)['data']['album']['photos'].first['thumbnailUrl'])
                .to eql('https://via.placeholder.com/150/92c952'))
          end
        end

        context 'when dont get a album by id' do
          before do
            album_search_request_not_found
            photos_for_album_not_found
            post '/graphql', params: { query: query_get_album(id: '10000000') }
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
