require 'search_object/plugin/graphql'

module Resolvers
  class ListAlbums
    include SearchObject.module(:graphql)

    scope { HTTParty.get(URL_FOR_PHOTOS).parsed_response }

    type types[Types::AlbumWithPhotoType]

    def apply_filter
      albums = HTTParty.get(URL_FOR_ALBUM).parsed_response
      add_photos_to_album(scope, albums)
    end

    def add_photos_to_album(list, albums)
      byebug
      albums.each do |elem|
        albums.photos = []
        list.each do |photo|
          albums.photos << elem if elem['id'].include? photo['albumId']
        end
      end
    end
  end
end
