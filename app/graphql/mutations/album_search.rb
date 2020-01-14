require 'httparty'

module Mutations
  class AlbumSearch < BaseMutation
    argument :album_id, String, required: true

    type Types::AlbumType

    def resolve(album_id: nil)
      HTTParty.get("https://jsonplaceholder.typicode.com/todos/#{album_id}").parsed_response
    end
  end
end
