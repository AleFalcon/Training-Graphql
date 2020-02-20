require 'rails_helper'

module Mutations
  module Users
    RSpec.describe CreatePurchasedAlbum, type: :request do
      describe '.resolve' do
        context 'when create a purchased album by user' do
          include_context 'with Authentication User'
          let(:expect_album) do
            { 'id' => '1', 'title' => 'delectus aut autem', 'userId' => '1' }
          end

          before do
            album_search_request_success
            user.email = user.first_name + '@wolox.com.ar'
            post '/graphql', params: { query: create_purchased_album(id: expect_album['id'].to_i) }
          end

          it 'record creation' do
            expect(PurchasedAlbum.count).to eq(1)
          end

          it 'return the album title' do
            expect(PurchasedAlbum.last.album_id).to eql(expect_album['id'])
          end

          it 'return the album id' do
            expect(PurchasedAlbum.last.album_title).to eql(expect_album['title'])
          end

          it 'return the user id' do
            expect(PurchasedAlbum.last.user).to eql(User.last)
          end
        end
      end
    end
  end
end
