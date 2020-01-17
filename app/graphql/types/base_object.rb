module Types
  class BaseObject < GraphQL::Schema::Object
    field_class Types::BaseField

    URL_FOR_ALBUM = 'https://jsonplaceholder.typicode.com/albums/'.freeze
    URL_FOR_PHOTOS = 'https://jsonplaceholder.typicode.com/photos'.freeze
  end
end
