module Types
  class UserType < BaseObject
    field :id, ID, null: false
    field :first_name, String, null: false,
                               deprecation_reason: 'Deprecated because the card requests it'
    field :last_name, String, null: false,
                              deprecation_reason: 'Deprecated because the card requests it'
    field :email, String, null: false
  end
end
