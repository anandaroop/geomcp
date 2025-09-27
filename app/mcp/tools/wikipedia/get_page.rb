class Tools::Wikipedia::GetPage < MCP::Tool
  tool_name "wikipedia_get_page"
  description "Get a Wikipedia page by ID using the Wikipedia API"
  input_schema(
    properties: {
      page_id: {type: "number", description: "ID of the Wikipedia page to retrieve"}
    },
    required: ["page_id"]
  )
  output_schema(
    type: "object",
    properties: {
      ns: {type: "number", description: "Namespace of the page"},
      pageid: {type: "number", description: "Unique identifier for the Wikipedia page"},
      title: {type: "string", description: "Title of the Wikipedia page"},
      coordinates: {
        type: "array",
        description: "Geographical coordinates associated with the page, if available",
        items: {
          type: "object",
          properties: {
            lat: {type: "number", description: "Latitude"},
            lon: {type: "number", description: "Longitude"},
            primary: {type: "string", description: "Indicates if this is the primary coordinate"},
            globe: {type: "string", description: "The celestial body the coordinates refer to"}
          },
          required: ["lat", "lon", "primary", "globe"]
        }
      },
      extract: {type: "string", description: "A snippet of text from the page, with search terms highlighted"}
    }
  )

  class << self
    def call(
      page_id:,
      server_context: nil
    )
      result = Wikipedia.get_page(page_id)

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
