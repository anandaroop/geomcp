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
      title: {type: "string", description: "Title of the Wikipedia page"},
      pageid: {type: "number", description: "Unique identifier for the Wikipedia page"},
      snippet: {type: "string", description: "A snippet of text from the page, with search terms highlighted"}
    }
  )

  class << self
    def call(
      page_id:,
      server_context: nil
    )
      result = Wikipedia.get_page(page_id)

      output_schema.validate_result(result)

      MCP::Tool::Response.new([{
        type: "text",
        text: result.to_json
      }])
    end
  end
end
