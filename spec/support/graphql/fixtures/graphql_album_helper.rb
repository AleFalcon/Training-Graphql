def mutation_list_album
  <<~GQL
    query{
      allAlbums(){
        id
        title
      }
    }
  GQL
end
