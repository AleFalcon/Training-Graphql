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

  def list_album(order_by, offset, limit)
    albums = parse_all_albums(HTTParty.get("#{endpoint}albums/"))
    list_new = order_array(apply_limit(apply_offset(albums, offset), limit), order_by)
    PhotosService.new(endpoint).add_photos_to_album(list_new)
  end

  private

  def parse_albums(response)
    response.parsed_response.transform_keys(&:underscore)
  end

  def parse_all_albums(response)
    response.parsed_response.map { |x| x.transform_keys(&:underscore) }
  end

  def apply_limit(list, value)
    return list.take(value) unless value.nil?

    list
  end

  def apply_offset(list, value)
    list.drop(value)
  end

  def order_array(list, value)
    list.sort_by! { |x| x[value.to_h[:field].to_s] }
    return list if value.to_h[:order].zero?

    list.reverse!
  end
end
