require 'rails_helper'
require 'support/graphql/fixtures/graphql_album_helper'

module Types
  module Albums
    RSpec.describe QueryType, type: :request do
      describe '.resolve' do
        context 'when list all album' do
          before do
            filter_list_album_request_success
            mocked_filtered_photos_album_1_success
            mocked_filtered_photos_album_79_success
            post '/graphql', params: { query: query_filter_list_album(title: 'quidem') }
          end

          it 'return the count albums of list' do
            expect(JSON.parse(response.body)['data']['albums'].count).to eq(2)
          end

          it 'return the id album of first album' do
            expect(JSON.parse(response.body)['data']['albums'].first['id']).to eq(1)
          end

          it 'return the title album of first album' do
            expect(JSON.parse(response.body)['data']['albums'].first['title'])
              .to eql('quidem molestiae enim')
          end

          it 'return the userId album of first album' do
            expect(JSON.parse(response.body)['data']['albums'].first['userId'])
              .to eql('1')
          end

          it 'return the count of photos of first album' do
            expect(JSON.parse(response.body)['data']['albums'].first['photos'].count)
              .to eq(6)
          end

          it 'return the first photos' do
            (expect(JSON.parse(response.body)['data']['albums']
            .first['photos'].first['id'])
              .to eql('1')) &&
              (expect(JSON.parse(response.body)['data']['albums']
              .first['photos'].first['title'])
                .to eql('accusamus beatae ad facilis cum similique qui sunt')) &&
              (expect(JSON.parse(response.body)['data']['albums']
              .first['photos'].first['url'])
                .to eql('https://via.placeholder.com/600/92c952')) &&
              (expect(JSON.parse(response.body)['data']['albums']
              .first['photos'].first['thumbnailUrl'])
                .to eql('https://via.placeholder.com/150/92c952'))
          end
        end
      end
    end
  end
end
