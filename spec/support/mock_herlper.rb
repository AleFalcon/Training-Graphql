module MockHelper
  def filter_list_album_request_success
    stub_request(:get, 'https://jsonplaceholder.typicode.com/albums')
      .to_return(
        status: 200,
        body: File.read('./spec/support/fixtures/mocked_filter_list_album_success.json'),
        headers: { 'Content-Type': 'application/json' }
      )
  end
end
