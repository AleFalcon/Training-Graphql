def query_get_album(albumId:)
  <<~GQL
    query{
      album(albumId:"#{albumId}"){
       id
        title
      }
    }
  GQL
end
