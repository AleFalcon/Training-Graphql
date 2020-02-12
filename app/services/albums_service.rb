class AlbumsService
  attr_accessor :endpoint

  def initialize(params)
    self.endpoint = params
  end

  def get_album(id)
    album = parse_album(HTTParty.get("#{endpoint}albums/#{id}"))
    album[:photos] = parse_photos(HTTParty.get("#{endpoint}photos?albumId=#{id}"))
    album
  end

  private

  def add_photos_to_album(albums)
    albums.each do |elem|
      elem['photos'] = parse_photos(HTTParty.get("#{endpoint}photos?albumId=#{elem['id']}"))
    end
    albums
  end

  def parse_albums(response)
    response.parsed_response.map { |x| x.transform_keys(&:underscore) }
  end

  def parse_album(response)
    response.parsed_response.transform_keys(&:underscore)
  end

  def parse_photos(response)
    response.parsed_response.map { |x| x.transform_keys(&:underscore) }
  end
end
