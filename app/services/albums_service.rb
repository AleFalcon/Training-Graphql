class AlbumsService
  def initialize(params)
    @endpoint = params
  end

  def list_albums
    albums = parse_albums(HTTParty.get("#{@endpoint}albums/"))
    add_photos_to_album(albums)
  end

  private

  def add_photos_to_album(albums)
    albums.each do |elem|
      elem['photos'] = parse_photos(HTTParty.get("#{@endpoint}photos?albumId=#{elem['id']}"))
    end
    albums
  end

  def parse_albums(response)
    response.parsed_response.map { |x| x.transform_keys(&:underscore) }
  end

  def parse_photos(response)
    response.parsed_response.map { |x| x.transform_keys(&:underscore) }
  end
end
