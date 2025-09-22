class Tools::GeoNames::Search < MCP::Tool
  description "Search for toponyms using the GeoNames API"
  input_schema(
    properties: {
      q: {type: "string", description: "Query terms to search for"},
      name_only: {type: "boolean", description: "If true, will search in ONLY the name field", default: false},
      max_rows: {type: "integer", description: "Maximum number of rows to return (default 10, max 1000)", default: 10, minimum: 1, maximum: 1000},
      start_row: {type: "integer", description: "Row number to start at (for pagination)", default: 0, minimum: 0, maximum: 5000},
      country: {type: "string", description: "ISO 3166-1 alpha-2 country code to restrict the search to a specific country (e.g., 'US' for United States)"},
      continent_code: {type: "string", description: "Continent code to restrict the search for toponym of the given continent (e.g., 'AF' for Africa, 'EU' for Europe)", enum: ["AF", "AS", "EU", "NA", "OC", "SA", "AN"]},
      feature_class: {
        type: "string",
        description: "Feature class to restrict the search (e.g., 'A' for administrative division, 'H' for hydrography and water features, 'P' for populated place, 'T' for physical terrain)",
        enum: ["A", "H", "L", "P", "R", "S", "T", "U", "V"]
      },
      feature_code: {type: "string", description: "Feature code to restrict the search (e.g. 'ADM1' for first-order administrative division, 'PPLC' for capital of a political entity)"},
      north: {type: "number", description: "Northernmost coordinate (latitude) to restrict the search to a bounding box", default: 90},
      east: {type: "number", description: "Easternmost coordinate (longitude) to restrict the search to a bounding box", default: 180},
      south: {type: "number", description: "Southernmost coordinate (latitude) to restrict the search to a bounding box", default: -90},
      west: {type: "number", description: "Westernmost coordinate (longitude) to restrict the search to a bounding box", default: -180},
      style: {
        type: "string",
        description: "Level of detail to return in the response. If an expected key is not in the default response, try using a more detailed style.",
        enum: ["FULL", "MEDIUM", "SHORT"],
        default: "MEDIUM"
      }
    },
    required: ["q"]
  )
  output_schema(
    type: "object",
    properties: {
      totalResultsCount: {type: "integer", description: "Total number of results found"},
      geonames: {
        type: "array",
        description: "Array of toponym records",
        items: {
          type: "object",
          properties: {
            adminCode1: {type: "string", description: "Code for the first-order administrative division (e.g., state, province)"},
            adminCode2: {type: "string", description: "Code for the second-order administrative division (e.g., county, district)"},
            adminCode3: {type: "string", description: "Code for the third-order administrative division (e.g., county, district)"},
            adminId1: {type: "string", description: "GeoNames ID for the associated first-order administrative division (e.g., state, province)"},
            adminId2: {type: "string", description: "GeoNames ID for the associated second-order administrative division (e.g., county, district)"},
            adminId3: {type: "string", description: "GeoNames ID for the associated third-order administrative division (e.g., county, district)"},
            adminName1: {type: "string", description: "Name of the first-order administrative division (e.g., state, province)"},
            adminName2: {type: "string", description: "Name of the second-order administrative division (e.g., county, district)"},
            adminName3: {type: "string", description: "Name of the third-order administrative division"},
            adminName4: {type: "string", description: "Name of the fourth-order administrative division"},
            adminName5: {type: "string", description: "Name of the fifth-order administrative division"},
            alternateNames: {
              type: "array",
              description: "List of alternate names for the toponym",
              items: {
                type: "object",
                properties: {
                  isShortName: {type: "boolean", description: "Indicates if this is a short name"},
                  lang: {type: "string", description: "Language code (e.g., 'en' for English, 'fr' for French)"},
                  name: {type: "string", description: "The alternate name"}
                }
              }
            },
            asciiName: {type: "string", description: "7-bit ASCII full name of the toponym"},
            astergdem: {type: "number", description: "ASTER Global Digital Elevation Map identifier"},
            bbox: {
              type: "object",
              description: "Bounding box of the toponym",
              properties: {
                east: {type: "number", description: "Easternmost longitude"},
                south: {type: "number", description: "Southernmost latitude"},
                north: {type: "number", description: "Northernmost latitude"},
                west: {type: "number", description: "Westernmost longitude"},
                accuracyLevel: {type: "number", description: "Accuracy level of the bounding box"}
              }
            },
            continentCode: {type: "string", description: "Code for the continent (e.g., 'NA' for North America)", enum: ["AF", "AS", "EU", "NA", "OC", "SA", "AN"]},
            countryCode: {type: "string", description: "ISO 3166-1 alpha-2 country code"},
            countryId: {type: "string", description: "GeoNames ID for the associated country"},
            countryName: {type: "string", description: "Name of the associated country"},
            # elevation: {type: "number", description: "Elevation in meters"}, # missing?
            fcl: {type: "string", description: "Feature class (e.g., 'A' for administrative division, 'H' for hydrography and water features, 'P' for populated place, 'T' for physical terrain)", enum: ["A", "H", "L", "P", "R", "S", "T", "U", "V"]},
            fclName: {type: "string", description: "Full name of the feature class"},
            fcode: {type: "string", description: "Feature code (e.g. 'ADM1' for first-order administrative division, 'PPLC' for capital of a political entity)"},
            fcodeName: {type: "string", description: "Name of the feature code"},
            geonameId: {type: "number", description: "GeoNames ID"},
            lat: {type: "string", description: "Latitude in decimal degrees"},
            lng: {type: "string", description: "Longitude in decimal degrees"},
            name: {type: "string", description: "Name of the toponym"},
            population: {type: "number", description: "Population"},
            score: {type: "number", description: "Relevance score (probably)"}, # TODO: confirm
            srtm3: {type: "number", description: "SRTM3 identifier (Shuttle Radar Topography Mission 3 arc seconds / 90m resolution)"},
            timezone: {
              type: "object",
              description: "Timezone information",
              properties: {
                gmtOffset: {type: "number", description: "Offset from GMT in hours"},
                timeZoneId: {type: "string", description: "IANA Time Zone ID (e.g., 'America/New_York')"},
                dstOffset: {type: "number", description: "Offset from GMT during Daylight Saving Time in hours"}
              }
            },
            toponymName: {type: "string", description: "Full name of the toponym"}
          }
        }
      }
    }
  )

  class << self
    def call(
      q:,
      name_only: false,
      max_rows: 10,
      start_row: nil,
      country: nil,
      continent_code: nil,
      feature_class: nil,
      feature_code: nil,
      north: 90,
      east: 180,
      south: -90,
      west: -180,
      style: nil,
      server_context: nil
    )
      criteria = {}
      if name_only
        criteria[:name] = q
      else
        criteria[:q] = q
      end

      criteria[:maxRows] = max_rows if max_rows
      criteria[:startRow] = start_row if start_row
      criteria[:country] = country if country
      criteria[:continentCode] = continent_code if continent_code
      criteria[:featureClass] = feature_class if feature_class
      criteria[:featureCode] = feature_code if feature_code
      criteria[:north] = north if north
      criteria[:east] = east if east
      criteria[:south] = south if south
      criteria[:west] = west if west
      criteria[:style] = style if style

      result = GeoNames::Search.search(criteria)

      output_schema.validate_result(result)

      MCP::Tool::Response.new([{
        type: "text",
        text: result.to_json
      }])
    end
  end
end
