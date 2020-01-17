module Types
  class QueryType < Types::BaseObject
    field :get_album, AlbumType, null: false do
      argument :album_id, String, required: true
    end

    def get_album(album_id:)
      HTTParty.get(URL_FOR_ALBUM + album_id).parsed_response
    end
  end
end
