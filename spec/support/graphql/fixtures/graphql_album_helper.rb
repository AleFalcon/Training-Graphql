def query_filter_list_album(title:)
  <<~GQL
    query{
      albums(filter: {title: "#{title}"}){
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
