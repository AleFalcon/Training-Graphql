module Types
  class QueryType < Types::BaseObject
    field :album, AlbumType, null: false do
      argument :album_id, String, required: true
    end

    def album(album_id:)
      photos = HTTParty.get(URL_FOR_PHOTOS).parsed_response
      album = HTTParty.get(URL_FOR_ALBUM + album_id).parsed_response
      add_photos_to_album(photos, album, album_id)
    end

    def add_photos_to_album(photos, album, album_id)
      album['photos'] = []
      photos.each do |photo|
        album['photos'] << photo if album_id.to_i == photo['albumId']
      end
      album
    end
  end
end
