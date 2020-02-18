class PhotosService
  attr_accessor :endpoint

  def initialize(params)
    self.endpoint = params
  end

  def add_photos_to_album(albums)
    albums.each do |elem|
      elem['photos'] = get_photo(elem['id'])
    end
    albums
  end

  def get_photo(id)
    parse_photos(HTTParty.get("#{endpoint}photos?albumId=#{id}"))
  end

  private

  def parse_photos(response)
    response.parsed_response.map { |x| x.transform_keys(&:underscore) }
  end
end
