require "csv"

class Tools::GeoJson::Preview < MCP::Tool
  tool_name "geojson_preview"
  description "Generate a URL for for previewing research data on http://geojson.io"
  input_schema(
    properties: {
      csv_data: {type: "string", description: "CSV data in the required research format"}
    },
    required: ["csv_data"]
  )
  output_schema(
    type: "object",
    properties: {
      url: {type: "string", description: "URL to preview the data on http://geojson.io"}
    }
  )

  class << self
    def call(
      csv_data:,
      server_context: nil
    )
      data = CSV.parse(csv_data, headers: true)

      features = data.map do |row|
        {
          type: "Feature",
          geometry: {
            type: "Point",
            coordinates: [row["longitude"].to_f, row["latitude"].to_f]
          },
          # properties: row.to_h.except("lon", "lat")
          properties: row.to_h.slice("searched", "found", "feature_type")
        }
      end
      geojson = {
        type: "FeatureCollection",
        features: features
      }
      encoded_geojson = CGI.escape(geojson.to_json)

      url = "http://geojson.io/#data=data:application/json,#{encoded_geojson}"
      result = {url: url}

      output_schema.validate_result(result)

      system "open", url if Rails.env.development?

      MCP::Tool::Response.new([{
        type: "text",
        text: url
      }])
    end
  end
end
