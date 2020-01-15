module MockHelper
  def list_all_album_request_success
    stub_request(:get, 'https://jsonplaceholder.typicode.com/albums')
      .to_return(
        status: 200,
        body: File.read('./spec/support/fixtures/mocked_list_all_album_success.json'),
        headers: { 'Content-Type': 'application/json' }
      )
  end
end
