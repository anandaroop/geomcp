module Tools; end

task stdio: :environment do
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
      Tools::Wikipedia::GetPage,
      Tools::Nominatim::Search

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

  # Create and start the transport
  transport = MCP::Server::Transports::StdioTransport.new(server)
  transport.open
end
