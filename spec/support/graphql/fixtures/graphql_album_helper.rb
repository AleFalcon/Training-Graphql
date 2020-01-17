def query_get_album(albumId:)
  <<~GQL
    query{
      getAlbum(albumId:"#{albumId}"){
       id
        title
      }
    }
  GQL
end
