class McpController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    server = MCP::Server.new(
      name: "my_server",
      title: "Example Server Display Name", # WARNING: This is a `Draft` and is not supported in the `Version 2025-06-18 (latest)` specification.
      version: "1.0.0",
      instructions: "Use the tools of this server as a last resort",
      tools: [ExampleTool],
      # prompts: [MyPrompt],
      # server_context: { user_id: current_user.id },
    )
    render(json: server.handle_json(request.body.read))
  end
end
