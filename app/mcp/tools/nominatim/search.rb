class Tools::Nominatim::Search < MCP::Tool
  tool_name "nominatim_search"
  description "Search for toponyms using the Nominatim API"
  input_schema(
    properties: {
      q: {type: "string", description: "Query terms to search for (may include a feature type, or a parent feature name)"},
      limit: {type: "number", description: "Maximum number of results to return (default 10, maximum 40)", default: 10, maximum: 40},
      namedetails: {type: "boolean", description: "Whether to include additional names for the toponym", default: false},
      countrycodes: {type: "string", description: "Comma-separated list of ISO 3166-1 alpha-2 country codes to restrict the search", default: nil},
      polygon_geojson: {type: "boolean", description: "Whether to return the polygon representation of the feature", default: false},
      feature_type: {type: "string", description: "Restrict results to country, state, city, settlement", default: nil, enum: ["country", "state", "city", "settlement"]}
    },
    required: ["q"]
  )
  output_schema(
    type: "object",
    properties: {
      type: {type: "string"},
      licence: {type: "string"},
      features: {
        type: "array",
        items: {
          type: "object",
          properties: {
            type: {type: "string", enum: ["Feature"]},
            properties: {
              type: "object",
              properties: {
                osm_id: {type: "number", description: "OpenStreetMap unique identifier"},
                osm_type: {type: "string", description: "Type of OpenStreetMap element", enum: ["node", "way", "relation"]},
                name: {type: "string", description: "Name of the toponym"},
                display_name: {type: "string", description: "Comma-separated reverse-hierarchical string"},
                place_id: {type: "number"},
                place_rank: {type: "number"},
                importance: {type: "number"},
                addresstype: {type: "string"},
                category: {type: "string"},
                type: {type: "string"}
              },
              required: ["osm_type", "osm_id", "name"]
            },
            bbox: {
              type: "array", items: {type: "number"}, description: "Array of bounding box coordinates [south, north, west, east]"
            },
            geometry: {
              type: "object",
              properties: {
                type: {type: "string", description: "GeoJSON geometry type", enum: ["Point", "LineString", "Polygon", "MultiPoint", "MultiLineString", "MultiPolygon"]},
                coordinates: {
                  type: "array",
                  items: {any_of: [{type: "number"}, {type: "array", items: {type: "number"}}]},
                  description: "Array of coordinates [longitude, latitude] for a Point, or array of such arrays for other geometry types"
                }
              },
              required: ["type", "coordinates"]
            }
          },
          required: ["type", "properties", "geometry"]
        }
      }
    },
    required: ["type", "features"]
  )

  class << self
    def call(
      q:,
      limit: nil,
      namedetails: false,
      countrycodes: nil,
      polygon_geojson: false,
      feature_type: nil,
      server_context: nil
    )
      result = Nominatim.search(
        q,
        limit: limit,
        namedetails: namedetails,
        countrycodes: countrycodes,
        polygon_geojson: polygon_geojson,
        feature_type: feature_type
      )

      output_schema.validate_result(result)

      MCP::Tool::Response.new(
        [{
          type: "text",
          text: result.to_json
        }],
        structured_content: result
      )
    end
  end
end
