class AlbumsService
  def initialize(params)
    @endopint = params
  end

  def get_album(id)
    album = parse_album(HTTParty.get("#{@endpoint}albums/#{id}"))
    album[:photos] = parse_photos(HTTParty.get("#{@endpoint}photos?albumId=#{id}"))
    album
  end

  private

  def parse_album(response)
    response.parsed_response.transform_keys(&:underscore)
  end

  def parse_photos(response)
    response.parsed_response.map { |x| x.transform_keys(&:underscore) }
  end
end
