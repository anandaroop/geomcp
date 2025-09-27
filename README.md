# GeoMCP

An MCP server that aids in geospatial research for cartography projects.

## Tools

It currently exposes the following tools:

- **geonames_country_bounding_box**
  - Return the bounding box for a given country using the GeoNames API
- **geonames_get**
  - Return details for a given toponym using the GeoNames API
- **geonames_search**
  - Search for toponyms using the GeoNames API
- **geojson_preview**
  - Generate a URL for for previewing research data on http://geojson.io
- **wikipedia_search**
  - Search Wikipedia for articles matching a given query
- **wikipedia_get_page**
  - Get a Wikipedia page by ID using the Wikipedia API

## Usage with Claude Code

This project contains settings for Claude Code that allow it to make smarter use of the MCP server via subagents.

### Subagents

- **place-name-researcher**
  - Uses the query tools to research place names and return them in a specific CSV format

## Cheat Sheet

```sh
# start the MCP server
$ bundle exec rails server

# run the mcp inspector
$ npx @modelcontextprotocol/inspector --transport http --server-url http://localhost:3000/mcp

# add the MCP server to Claude Code
$ claude mcp add --scope project --transport http geomcp "http://localhost:3000/mcp"

# launch Claude Code
$ claude

╭───────────────────────────╮
│ ✻ Welcome to Claude Code! │
╰───────────────────────────╯

# request research via the research subagent
> @place-name-researcher give me a CSV with New Orleans and New York

# preview the results on a globe at http://geojson.io
> preview those results
```
