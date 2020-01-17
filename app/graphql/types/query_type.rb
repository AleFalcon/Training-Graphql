module Types
  class QueryType < Types::BaseObject
    URL_FOR_ALBUM = 'https://jsonplaceholder.typicode.com/albums/'.freeze

    field :album, AlbumType, null: false do
      argument :id, ID, required: true
    end

    def album(id:)
      HTTParty.get(URL_FOR_ALBUM + id).parsed_response.transform_keys(&:underscore)
    end
  end
end
