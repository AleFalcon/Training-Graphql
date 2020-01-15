def mutation_get_album(albumId:)
  <<~GQL
    mutation{
      albumId(albumId: "#{albumId}"){
        id
        title
      }
    }
  GQL
end
