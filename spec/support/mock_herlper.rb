module MockHelper
  def list_all_album_request_success
    stub_request(:get, 'https://jsonplaceholder.typicode.com/albums')
      .to_return(
        status: 200,
        body: File.read('./spec/support/fixtures/mocked_list_all_album_success.json'),
        headers: { 'Content-Type': 'application/json' }
      )
  end

  def photos_for_album_1_success
    stub_request(:get, 'https://jsonplaceholder.typicode.com/photos?albumId=1')
      .to_return(
        status: 200,
        body: File.read('./spec/support/fixtures/mocked_photos_album_1_success.json'),
        headers: { 'Content-Type': 'application/json' }
      )
  end

  def photos_for_album_2_success
    stub_request(:get, 'https://jsonplaceholder.typicode.com/photos?albumId=2')
      .to_return(
        status: 200,
        body: File.read('./spec/support/fixtures/mocked_photos_album_2_success.json'),
        headers: { 'Content-Type': 'application/json' }
      )
  end
end
