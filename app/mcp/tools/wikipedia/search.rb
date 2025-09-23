class Tools::Wikipedia::Search < MCP::Tool
  tool_name "wikipedia_search"
  description "Search for toponyms using the Wikipedia API"
  input_schema(
    properties: {
      q: {type: "string", description: "Query terms to search for"}
    },
    required: ["q"]
  )
  output_schema(
    type: "object",
    properties: {
      searchInfo: {
        type: "object",
        properties: {
          totalHits: {type: "number", description: "Total number of matching pages for the query"}
        }
      },
      search: {
        type: "array",
        description: "Array of search results",
        items: {
          type: "object",
          properties: {
            ns: {type: "number", description: "Namespace of the page"},
            title: {type: "string", description: "Title of the Wikipedia page"},
            pageid: {type: "number", description: "Unique identifier for the Wikipedia page"},
            snippet: {type: "string", description: "A snippet of text from the page, with search terms highlighted"}
          }
        }
      }
    }
  )

  class << self
    def call(
      q:,
      server_context: nil
    )
      result = Wikipedia.search(q)

      output_schema.validate_result(result)

      MCP::Tool::Response.new([{
        type: "text",
        text: result.to_json
      }])
    end
  end
end
