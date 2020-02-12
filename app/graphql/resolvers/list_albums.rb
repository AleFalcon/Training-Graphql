require 'search_object/plugin/graphql'

module Resolvers
  class ListAlbums < Types::QueryType
    include SearchObject.module(:graphql)

    scope { parse_albums(HTTParty.get("#{ENDPOINT}albums/")) }

    type types[Types::AlbumType]

    class AlbumsSort < ::Types::BaseInputObject
      FieldEnum = GraphQL::EnumType.define do
        name 'Fields'
        description 'fields by which you can sort'
        value('TITLE', 'Title of album', value: 'title')
        value('USER_ID', 'User id of album owner', value: 'user_id')
        value('ID', 'Id of album', value: 'id')
      end

      OrderEnum = GraphQL::EnumType.define do
        name 'Order'
        description 'Sort by'
        value('ASC', 'Ascending order', value: 0)
        value('DESC', 'Descending order', value: 1)
      end

      argument :order, OrderEnum, required: false, description: 'Sort by title or user id'
      argument :field, FieldEnum, required: false, description: 'Sort by title or user id'
    end

    option :first, type: types.Int, with: :apply_first
    option :skip, type: types.Int, with: :apply_skip
    option :orderBy, type: AlbumsSort, required: false, with: :list_albums

    def list_albums(scope, value)
      add_photos_to_album(order_array(scope, value))
    end

    def order_array(list, value)
      if value.to_h[:order].zero?
        list.sort_by! { |x| x[value.to_h[:field].to_s] }
      else
        list.sort_by { |x| x[value.to_h[:field].to_s] }.reverse!
      end
    end

    def add_photos_to_album(albums)
      albums.each do |elem|
        elem['photos'] = parse_photos(HTTParty.get("#{ENDPOINT}photos?albumId=#{elem['id']}"))
      end
      albums
    end

    def parse_albums(response)
      response.parsed_response.map { |x| x.transform_keys(&:underscore) }
    end

    def parse_photos(response)
      response.parsed_response.map { |x| x.transform_keys(&:underscore) }
    end
  end
end
