module Types
  class QueryType < Types::BaseObject
    ENDPOINT = 'https://jsonplaceholder.typicode.com/'.freeze

    field :album, AlbumType, null: false do
      argument :id, ID, required: true
    end

    def album(id:)
      AlbumsService.new.get_album(id, ENDPOINT)
    end
  end
end
