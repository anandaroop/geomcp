class McpController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    server = MCP::Server.new(
      name: "geomcp",
      title: "Geospatial MCP Server",
      version: "1.0.0",
      instructions: "Use for geospatial and cartographic queries",
      tools: [
        Tools::GeoNames::BoundingBox,
        Tools::GeoNames::Get,
        Tools::GeoNames::Search,
        Tools::GeoJson::Preview,
        Tools::Wikipedia::Search,
        Tools::Wikipedia::GetPage
      ],
      resources: [
        MCP::Resource.new(
          uri: "file://data/countries/countries.json",
          name: "countries-reference",
          title: "Countries Reference",
          description: "A JSON array of country objects, each with names, ISO 2 letter codes, and lat/lng center points.",
          mime_type: "text/plain"
        )

      ]
      # prompts: [MyPrompt],
      # server_context: { user_id: current_user.id },
    )

    server.resources_read_handler do |params|
      # corresponding file is assumed to exist in app/mcp/resources
      path = File.join(Rails.root, "app", "mcp", "resources", params[:uri].sub("file://", ""))
      contents = File.read(path)
      [{
        uri: params[:uri],
        mimeType: "text/plain",
        text: contents
      }]
      # end
    end

    render(json: server.handle_json(request.body.read))
  end
end
