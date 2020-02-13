class AlbumsService
  attr_accessor :endpoint

  def initialize(params)
    self.endpoint = params
  end

  def get_album(id)
    album = parse_albums(HTTParty.get("#{endpoint}albums/#{id}"))
    album[:photos] = PhotosService.new(endpoint).get_photo(id)
    album
  end

  def list_all_albums
    parse_all_albums(HTTParty.get("#{endpoint}albums/"))
  end

  private

  def parse_albums(response)
    response.parsed_response.transform_keys(&:underscore)
  end

  def parse_all_albums(response)
    response.parsed_response.map { |x| x.transform_keys(&:underscore) }
  end
end
