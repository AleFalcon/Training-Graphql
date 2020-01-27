def query_list_album
  <<~GQL
    query{
      albums(){
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
