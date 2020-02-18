module Types
  class QueryType < Types::BaseObject
    ENDPOINT = 'https://jsonplaceholder.typicode.com/'.freeze

    field :album, AlbumType, null: false do
      argument :id, ID, required: true
    end

    field :albums, [AlbumType], null: false do
      argument :order_by, type: OrderType::AlbumsSort, required: false
      argument :offset, type: Int, required: false
      argument :limit, type: Int, required: false
      argument :filter, type: String, required: false
      description 'List all albums'
    end

    def album(id:)
      AlbumsService.new(ENDPOINT).get_album(id)
    end

    def albums(order_by: { field: :id, order: 0 }, offset: 0, limit: nil, filter: '')
      AlbumsService.new(ENDPOINT).list_album(order_by, offset, limit, filter)
    end
  end
end
