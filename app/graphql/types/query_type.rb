module Types
  class QueryType < Types::BaseObject
    field :albums, [AlbumWithPhotoType], null: false

    def albums
      photos = HTTParty.get(URL_FOR_PHOTOS).parsed_response
      albums = HTTParty.get(URL_FOR_ALBUM).parsed_response
      add_photos_to_album(photos, albums)
    end

    def add_photos_to_album(photos, albums)
      albums.each do |elem|
        elem['photos'] = []
        photos.each do |photo|
          elem['photos'] << photo if elem['id'] == photo['albumId']
        end
      end
      albums
    end
  end
end
