def query_filter_list_album(title:)
  <<~GQL
    query{
      albums(filter: "#{title}"){
        userId
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
