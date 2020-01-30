module Types
  class UserType < BaseObject
    field :id, ID, null: false
    field :first_name, String, null: false,
                               deprecation_reason: 'Deprecated because the card requests it'
    field :last_name, String, null: false,
                              deprecation_reason: 'Deprecated because the card requests it'
    field :email, String, null: false
    field :name, String, null: false,
                         description: 'Field that concatenates the first_name and the last_name'

    def name
      object.first_name + ' ' + object.last_name
    end
  end
end
