class McpController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    server = MCP::Server.new(
      name: "geomcp",
      title: "Geospatial MCP Server",
      version: "1.0.0",
      instructions: "Use for geospatial and cartographic queries",
      tools: [
        Tools::GeoNames::BoundingBox
      ]
      # prompts: [MyPrompt],
      # server_context: { user_id: current_user.id },
    )
    render(json: server.handle_json(request.body.read))
  end
end
