---
name: creating-basemaps
description: Generate a vector basemap of a given region with physical features such as land, rivers and lakes as well as cultural features such as boundaries and populated places. Use this skill when the user wants "create a new map from scratch" or "create a basemap" or "create a vector map" etc.
---

# Creating Basemaps

You will write a temporary script to extract the necessary data to a folder in the current working directory.

Use the following checklist to track your work:

```
- [ ] Determine the the appropriate data resolution
- [ ] Determine the requested extent and buffer it by 20%
- [ ] Ensure a unique destination folder name (append a simple serial number if needed)
- [ ] Confirm the resolution & extent & folder name
- [ ] Write the extraction script
- [ ] Run the extraction script
```

## Data

- Basemaps are generated from the Natural Earth dataset (https://www.naturalearthdata.com)

- A local copy is stored at `/Users/Shared/Geodata/ne`

- The following data resolutions are available

  - `10m` - 1:10,000,000 scale (greatest detail) -- **this will be the default**, unless asked for a small-scale or zoomed out map
  - `50m` - 1:50,000,000 scale (moderate detail)
  - `110m` - 1:110,000,000 scale (least detail)

- The following thematic layers are the ones most commonly used:
  - Physical
    - `coastline` (lines)
    - `lakes` (areas)
    - `lakes_historic` (areas)
    - `land` (areas)
    - `rivers_lake_centerlines_scale_rank` (lines)
    - `glaciated_areas` (areas)
  - Cultural
    - `admin_0_countries` (areas)
    - `admin_0_boundary_lines_disputed_areas` (lines)
    - `admin_0_boundary_lines_land` (lines)
    - `admin_1_states_provinces_lines` (lines)
    - `admin_1_states_provinces` (areas)
    - `admin_1_states_provinces_scale_rank` (areas, full detail)
    - `populated_places_simple` (points)
  - Others
    - if other layers are specifically requested, see **Additional layers** below, or refer to https://www.naturalearthdata.com/features/ to see what else is available

## Tools

- **Tools**: Data is extracted using the command line tool `ogr2ogr` from GDAL (https://gdal.org)

- GDAL is installed locally via Homebrew

## Naming conventions

Data should be extracted to a single parent folder whose name reflects the dataset (`ne`), the resolution (`10m` vs `50m` vs `110m`) and the geographic extent (xmin ymin xmax ymax, i.e. southwest to northeast, i.e. bottom-left to top-right)

For example, if the dataset is `10m` and extent is:

- xmin: -91
- ymin: 29
- xmax: -89
- ymax: 31

Then the corresponding folder would be called `ne-10m--91-29--89-31` i.e. `ne-<scale>-<xmin>-<ymin>-<xmax>-<ymax>`

## Sample script

A typical basemap would consist of the layers

- `land`
- `lakes`
- `rivers_lake_centerlines_scale_rank`
- `admin_0_countries`
- `admin_0_boundary_lines_disputed_areas`
- `admin_0_boundary_lines_land`
- `admin_1_states_provinces_scale_rank`
- `admin_1_states_provinces_lines`

And the script to generate them would consist of several lines of the form:

```
ogr2ogr -spat <extent> -clipsrc spat_extent <destination folder> /Users/Shared/Geodata/ne/<source data layer>
```

Given the example geographic extent above, a full script would be named `extract-new-orleans-basemap.sh` and look as follows:

```sh
# PHYSICAL

# land
ogr2ogr -spat -91 29 -89 31 -clipsrc spat_extent ne-10m--91-29--89-31 /Users/Shared/Geodata/ne/10m_physical/ne_10m_land.shp
# lakes
ogr2ogr -spat -91 29 -89 31 -clipsrc spat_extent ne-10m--91-29--89-31 /Users/Shared/Geodata/ne/10m_physical/ne_10m_lakes.shp
# rivers
ogr2ogr -spat -91 29 -89 31 -clipsrc spat_extent ne-10m--91-29--89-31 /Users/Shared/Geodata/ne/10m_physical/ne_10m_rivers_lake_centerlines_scale_rank.shp

# CULTURAL

# countries
ogr2ogr -spat -91 29 -89 31 -clipsrc spat_extent ne-10m--91-29--89-31 /Users/Shared/Geodata/ne/10m_cultural/ne_10m_admin_0_countries.shp
ogr2ogr -spat -91 29 -89 31 -clipsrc spat_extent ne-10m--91-29--89-31 /Users/Shared/Geodata/ne/10m_cultural/ne_10m_admin_0_boundary_lines_disputed_areas.shp
ogr2ogr -spat -91 29 -89 31 -clipsrc spat_extent ne-10m--91-29--89-31 /Users/Shared/Geodata/ne/10m_cultural/ne_10m_admin_0_boundary_lines_land.shp
# states
ogr2ogr -spat -91 29 -89 31 -clipsrc spat_extent ne-10m--91-29--89-31 /Users/Shared/Geodata/ne/10m_cultural/ne_10m_admin_1_states_provinces_scale_rank.shp
ogr2ogr -spat -91 29 -89 31 -clipsrc spat_extent ne-10m--91-29--89-31 /Users/Shared/Geodata/ne/10m_cultural/ne_10m_admin_1_states_provinces_lines.shp
```

### Additional layers

If towns, cities or populated places are **specifically** requested, also include:

```sh
ogr2ogr -spat -91 29 -89 31 -clipsrc spat_extent ne-10m--91-29--89-31 /Users/Shared/Geodata/ne/10m_physical/ne_10m_populated_places_simple.shp
```

If historic lakes or water bodies are **specifically** requested, also include:

```sh
ogr2ogr -spat -91 29 -89 31 -clipsrc spat_extent ne-10m--91-29--89-31 /Users/Shared/Geodata/ne/10m_physical/ne_10m_lakes_historic.shp
```

If glaciated areas or snowcaps are **specifically** requested, also include:

```sh
ogr2ogr -spat -91 29 -89 31 -clipsrc spat_extent ne-10m--91-29--89-31 /Users/Shared/Geodata/ne/10m_physical/ne_10m_glaciated_areas.shp
```
