def query_filter_list_album(title:)
  <<~GQL
    query{
      allAlbums(filter: {title: "#{title}"}){
        id
        title
      }
    }
  GQL
end
