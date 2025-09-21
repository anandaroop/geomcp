class Tools::GeoNames::Get < MCP::Tool
  description "Return details for a given toponym using the GeoNames API"
  input_schema(
    properties: {
      geoname_id: {type: "string", description: "GeoNames ID for the toponym (e.g., '123456' for a specific place)"}
    },
    required: ["geoname_id"]
  )
  output_schema(
    type: "object",
    properties: {
      adminCode1: {type: "string", description: "Code for the first-order administrative division (e.g., state, province)"},
      adminCode2: {type: "string", description: "Code for the second-order administrative division (e.g., county, district)"},
      adminId1: {type: "string", description: "GeoNames ID for the associated first-order administrative division (e.g., state, province)"},
      adminId2: {type: "string", description: "GeoNames ID for the associated second-order administrative division (e.g., county, district)"},
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
      elevation: {type: "number", description: "Elevation in meters"},
      fcl: {type: "string", description: "Feature class (e.g., 'A' for administrative division, 'H' for hydrography and water features, 'P' for populated place, 'T' for physical terrain)", enum: ["A", "H", "L", "P", "R", "S", "T", "U", "V"]},
      fclName: {type: "string", description: "Full name of the feature class"},
      fcode: {type: "string", description: "Feature code (e.g. 'ADM1' for first-order administrative division, 'PPLC' for capital of a political entity)"},
      fcodeName: {type: "string", description: "Name of the feature code"},
      geonameId: {type: "number", description: "GeoNames ID"},
      lat: {type: "string", description: "Latitude in decimal degrees"},
      lng: {type: "string", description: "Longitude in decimal degrees"},
      name: {type: "string", description: "Name of the toponym"},
      population: {type: "number", description: "Population"},
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
  )

  class << self
    def call(
      geoname_id:,
      server_context: nil
    )
      result = GeoNames::Get.search({geonameId: geoname_id})

      output_schema.validate_result(result)

      MCP::Tool::Response.new([{
        type: "text",
        text: result.to_json
      }])
    end
  end
end
