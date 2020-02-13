require 'search_object/plugin/graphql'

module Resolvers
  class ListAlbums < Types::QueryType
    include SearchObject.module(:graphql)

    scope { AlbumsService.new(ENDPOINT).list_all_albums }

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

    option :offset, type: types.Int, with: :apply_offset
    option :limit, type: types.Int, with: :apply_limit
    option :orderBy, type: AlbumsSort, required: false, with: :list_albums

    def apply_limit(scope, value)
      scope.take(value)
    end

    def apply_offset(scope, value)
      scope[value..scope.length]
    end

    def list_albums(scope, value)
      PhotosService.new(ENDPOINT).add_photos_to_album(order_array(scope, value))
    end

    def order_array(list, value)
      if value.to_h[:order].zero?
        list.sort_by! { |x| x[value.to_h[:field].to_s] }
      else
        list.sort_by { |x| x[value.to_h[:field].to_s] }.reverse!
      end
    end
  end
end
