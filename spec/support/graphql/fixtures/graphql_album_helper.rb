def query_list_album(offset:, limit:, order_by:)
  <<~GQL
    query{
      albums(offset: #{offset}, limit: #{limit}, orderBy: #{order_by}){
        id
        title
        photos {
          id
          title
          url
          thumbnailUrl
        }
      }
    }
  GQL
end

def create_order(field:, order:)
  <<~GQL
    { field: #{field}, order:#{order} }
  GQL
end

def query_get_album(id:)
  <<~GQL
    query{
      album(id:"#{id}"){
        id
        title
        userId
        photos {
          id
          title
          url
          thumbnailUrl
        }
      }
    }
  GQL
end
