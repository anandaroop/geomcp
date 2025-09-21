class Tools::GeoNames::BoundingBox < MCP::Tool
  description "Return the bounding box for a given country using the GeoNames API"
  input_schema(
    properties: {
      country_code: {type: "string", description: "ISO 3166-1 alpha-2 country code (e.g., 'US' for United States)"}
    },
    required: ["country_code"]
  )
  output_schema(
    type: "object",
    properties: {
      north: {type: "number", description: "Northernmost latitude"},
      east: {type: "number", description: "Easternmost longitude"},
      south: {type: "number", description: "Southernmost latitude"},
      west: {type: "number", description: "Westernmost longitude"}
    },
    required: ["north", "east", "south", "west"]
  )

  class << self
    def call(
      country_code:,
      server_context: nil
    )
      north, east, south, west = GeoNames::CountryInfo.search({maxRows: 1, country: country_code})["geonames"][0].values_at("north", "east", "south", "west")
      bbox = {north:, east:, south:, west:}

      output_schema.validate_result(bbox)

      MCP::Tool::Response.new([{
        type: "text",
        text: bbox.to_json
      }])
    end
  end
end
