class AlbumsService
  attr_accessor :endpoint

  def initialize(params)
    self.endpoint = params
  end

  def get_album(id)
    album = parse_albums(HTTParty.get("#{endpoint}albums/#{id}"))
    album[:photos] = PhotosService.new.parse_photos(HTTParty.get("#{endpoint}photos?albumId=#{id}"))
    album
  end

  def parse_albums(response)
    response.parsed_response.map { |x| x.transform_keys(&:underscore) }
  end
end
