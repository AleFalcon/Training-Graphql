require 'search_object/plugin/graphql'

class Resolvers::ListAlbums
  # include SearchObject for GraphQL
  include SearchObject.module(:graphql)

  # scope is starting point for search
  scope { HTTParty.get('https://jsonplaceholder.typicode.com/albums').parsed_response }

  type types[Types::AlbumType]

  # inline input type definition for the advance filter
  class AlbumsFilter < ::Types::BaseInputObject
    argument :OR, [self], required: false
    argument :title, String, required: false
  end

  # when "filter" is passed "apply_filter" would be called to narrow the scope
  option :first, type: types.Int, with: :apply_first
  option :skip, type: types.Int, with: :apply_skip
  option :filter, type: AlbumsFilter, with: :apply_filter

  # apply_filter recursively loops through "OR" branches
  def apply_filter(scope, value)
    normalize_filters(scope, value)
  end

  def normalize_filters(list, value, result = [])
    list.each do |elem|
      if (elem["title"].include? value.to_h[:title])
        result << elem
      end
    end
    result
  end
end