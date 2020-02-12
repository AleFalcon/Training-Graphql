require 'search_object/plugin/graphql'

module Resolvers
  class ListAlbums < Types::QueryType
    # include SearchObject for GraphQL
    include SearchObject.module(:graphql)

    # scope is starting point for search
    scope { HTTParty.get("#{ENDPOINT}albums/").parsed_response }

    type types[Types::AlbumType]

    # inline input type definition for the advance filter
    class AlbumsSort < ::Types::BaseInputObject
      FielEnum = GraphQL::EnumType.define do
        name 'Fields'
        description 'fields by which you can sort'
        value('TITLE', 'Title of album')
        value('USER_ID', 'User id of album owner')
        value('ID', 'Id of album')
      end

      OrderEnum = GraphQL::EnumType.define do
        name 'Order'
        description 'Sort by'
        value('ASC', 'Ascending order')
        value('DESC', 'Descending order')
      end

      argument :order, OrderEnum, required: false, description: 'Sort by title or user id'
      argument :field, FielEnum, required: false, description: 'Sort by title or user id'
    end

    # when "filter" is passed "apply_filter" would be called to narrow the scope
    option :first, type: types.Int, with: :apply_first
    option :skip, type: types.Int, with: :apply_skip
    option :orderBy, type: AlbumsSort, required: false

    # apply_filter recursively loops through "OR" branches
    def list_albums(scope, value)
      add_photos_to_album(normalize_filters(scope, value))
    end

    def normalize_filters(list, value, result = [])
      list.each do |elem|
        result << elem if elem['title'].include? value.to_h[:title]
      end
      result
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