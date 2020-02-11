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
