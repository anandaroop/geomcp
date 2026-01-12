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
- **nominatim_search**
  - Search for toponyms using the OSM' Nominatim API

## Usage with Claude Code

`geomcp` can be added as an MCP server to Claude Code.

This project also contains settings that allow Claude Code use the MCP server in a specific way via subagents.

### Subagents

- **place-name-researcher**
  - Uses the query tools to research place names and return them in a specific CSV format that I have used historically

### Cheat Sheet

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

# make use of the `creating-basemaps` skill
> basemap of New York state, including towns, with a 30% buffer
```

## Usage with `georesearch`

My preferred way to use this is via a separate custom-built CLI at https://github.com/anandaroop/georesearch.
