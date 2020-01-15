module MockHelper
  def album_search_request_success
    stub_request(:get, 'https://jsonplaceholder.typicode.com/todos/1')
      .to_return(
        status: 200,
        body: File.read('./spec/support/fixtures/mocked_album_search_success.json'),
        headers: { 'Content-Type': 'application/json' }
      )
  end

  def album_search_request_not_found
    stub_request(:get, 'https://jsonplaceholder.typicode.com/todos/10000000')
      .to_return(
        status: 200,
        body: File.read('./spec/support/fixtures/mocked_album_search_not_found.json'),
        headers: { 'Content-Type': 'application/json' }
      )
  end
end
