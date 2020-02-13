require 'rails_helper'

module Types
  module Albums
    RSpec.describe QueryType, type: :request do
      describe '.resolve' do
        context 'when list all album' do
          let(:expect_photo) do
            {
              'id'=>'1',
              'thumbnailUrl'=>'https://via.placeholder.com/150/92c952',
              'title'=>'accusamus beatae ad facilis cum similique qui sunt',
              'url'=>'https://via.placeholder.com/600/92c952'
            }
          end

          let(:expect_album) do
            { 'id'=>'1',
              'title'=>'quidem molestiae enim',
              'photos'=>[
                expect_photo
              ]
            }
          end

          before do
            list_all_album_request_success
            photos_for_album_1_success
            photos_for_album_2_success
            post '/graphql', params: {
              query: query_list_album(offset: 0,
                                      limit: 1,
                                      order_by: create_order(field: 'ID', order: 'ASC'))
            }
          end

          it 'return the count albums of list' do
            expect(JSON.parse(response.body)['data']['albums'].count).to eq(1)
          end

          it 'return the album' do
            (expect(JSON.parse(response.body)['data']['albums'].first)
            .to eq expect_album)
          end
        end
      end
    end
  end
end
