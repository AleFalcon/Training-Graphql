require 'rails_helper'

module Types
  module Albums
    RSpec.describe QueryType, type: :request do
      describe '.resolve' do
        context 'when list all album' do
          let(:expect_photo) do
            { 'id' => '1', 'thumbnailUrl' => 'https://via.placeholder.com/150/92c952',
              'title' => 'accusamus beatae ad facilis cum similique qui sunt',
              'url' => 'https://via.placeholder.com/600/92c952' }
          end

          let(:expect_album) do
            { 'id' => '1',
              'photos' => [
                expect_photo
              ],
              'title' => 'quidem molestiae enim', 'userId' => '1' }
          end

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
            (expect(JSON.parse(response.body)['data']['albums'].first).to eq expect_album)
          end
        end
      end
    end
  end
end
