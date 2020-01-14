require 'search_object/plugin/graphql'

module Resolvers
  class ListAllAlbums
    include SearchObject.module(:graphql)

    scope { HTTParty.get('https://jsonplaceholder.typicode.com/albums').parsed_response }

    type types[Types::AlbumType]

    def apply_filter
      scope
    end
  end
end
