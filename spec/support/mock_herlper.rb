module MockHelper
  def filter_list_album_request_success
    stub_request(:get, 'https://jsonplaceholder.typicode.com/albums/')
      .to_return(
        status: 200,
        body: File.read('./spec/support/fixtures/mocked_filter_list_album_success.json'),
        headers: { 'Content-Type': 'application/json' }
      )
  end

  def mocked_filtered_photos_album_1_success
    stub_request(:get, 'https://jsonplaceholder.typicode.com/photos?albumId=1')
      .to_return(
        status: 200,
        body: File.read('./spec/support/fixtures/mocked_filtered_photos_album_1_success.json'),
        headers: { 'Content-Type': 'application/json' }
      )
  end

  def mocked_filtered_photos_album_79_success
    stub_request(:get, 'https://jsonplaceholder.typicode.com/photos?albumId=79')
      .to_return(
        status: 200,
        body: File.read('./spec/support/fixtures/mocked_filtered_photos_album_79_success.json'),
        headers: { 'Content-Type': 'application/json' }
      )
  end
end
