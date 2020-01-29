module MockHelper
  def album_search_request_success
    stub_request(:get, 'https://jsonplaceholder.typicode.com/albums/1')
      .to_return(
        status: 200,
        body: File.read('./spec/support/fixtures/mocked_album_search_success.json'),
        headers: { 'Content-Type': 'application/json' }
      )
  end

  def album_search_request_not_found
    stub_request(:get, 'https://jsonplaceholder.typicode.com/albums/10000000')
      .to_return(
        status: 404,
        body: File.read('./spec/support/fixtures/mocked_album_search_not_found.json'),
        headers: { 'Content-Type': 'application/json' }
      )
  end

  def photos_for_album_success
    stub_request(:get, 'https://jsonplaceholder.typicode.com/photos?albumId=1')
      .to_return(
        status: 200,
        body: File.read('./spec/support/fixtures/mocked_photos_album_success.json'),
        headers: { 'Content-Type': 'application/json' }
      )
  end

  def photos_for_album_not_found
    stub_request(:get, 'https://jsonplaceholder.typicode.com/photos?albumId=10000000')
      .to_return(
        status: 404,
        body: File.read('./spec/support/fixtures/mocked_photos_album_not_found.json'),
        headers: { 'Content-Type': 'application/json' }
      )
  end
end
