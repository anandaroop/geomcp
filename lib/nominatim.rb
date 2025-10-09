class Nominatim
  include HTTParty

  def self.search(
    query,
    limit: nil,
    namedetails: false,
    countrycodes: nil,
    polygon_geojson: false,
    feature_type: nil
  )
    params = {
      q: query,
      format: "geojson"
    }
    params[:limit] = limit if limit
    params[:namedetails] = 1 if namedetails
    params[:countrycodes] = countrycodes if countrycodes
    params[:polygon_geojson] = 1 if polygon_geojson
    params[:featuretype] = feature_type if feature_type

    options = {
      query: params,
      headers: {"User-Agent" => ENV["NOMINATIM_USER_AGENT"]}
    }
    Rails.logger.info("Nominatim API request: #{params}")
    response = get("https://nominatim.openstreetmap.org/search", options)
    pp response
    response.to_h
  end

  # def self.lookup(osm_id)
  #   params = {
  #     osm_ids: "R" + osm_id.to_s, # R for relation may not always be right
  #     format: "geojson"
  #   }
  #   options = {
  #     query: params,
  #     headers: {"User-Agent" => ENV["NOMINATIM_USER_AGENT"]}
  #   }
  #   Rails.logger.info("Nominatim API request: #{params}")
  #   response = get("https://nominatim.openstreetmap.org/lookup", options)
  #   response.to_h
  # end
end
