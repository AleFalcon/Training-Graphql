module Types
  class OrderType
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
  end
end
