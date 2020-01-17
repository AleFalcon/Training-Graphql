module Types
  class BaseObject < GraphQL::Schema::Object
    field_class Types::BaseField

    URL_FOR_ALBUM = 'https://jsonplaceholder.typicode.com/todos/'.freeze
  end
end
