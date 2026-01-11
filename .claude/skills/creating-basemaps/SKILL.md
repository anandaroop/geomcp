---
name: creating-basemaps
description: Generate a vector basemap of a given region with physical features such as land, rivers and lakes as well as cultural features such as boundaries and populated places. Use this skill when the user wants "create a new map from scratch" or "create a basemap" or "create a vector map" etc.
---

# Creating Basemaps

You will use the `ne` utility to extract the necessary basemap data.

Use the following checklist to track your workflow:

```
- [ ] Determine the appropriate data resolution
- [ ] Determine the requested extent
- [ ] Construct the `ne` command
- [ ] Confirm the `ne` command
- [ ] Extract the data
- [ ] Display the data
```

## Workflow

### Determine the appropriate data resolution

- The following data resolutions are available

  - `10m` - 1:10,000,000 scale (greatest detail) -- **this will be the default**, unless asked for a small-scale or zoomed out map
  - `50m` - 1:50,000,000 scale (moderate detail)
  - `110m` - 1:110,000,000 scale (least detail)

### Determine the requested extent

Determine a bounding box (aka envelope) for the requested region.

Use tools from the `geomcp` MCP server, if needed.

### Construct the `ne` command

Run the following commands to understand what `ne` provides

```sh
# main subcommand and flags
ne extract --help

# extensive sample usage
ne examples
```

Use that to construct a full `ne` command invocation.

#### Buffer option

IMPORTANT: by default you will request a buffer of 20%, unless user requests otherwise.

#### Layers option

If the user requests specific layers you may also use the `ne list` subcommand to better understand what is available.

```sh
# main subcommand and flags
ne list --help

# default layers
ne list --default
```

#### Output option

Rely on the default (cwd) unless specifically requested otherwise

### Confirm the `ne` command

Display the `ne` command and confirm it has been constructed correctly

### Display the data

Finally display the generated data to the user by issuing a command:

```sh
open /full/path/to/destination/dir
```
