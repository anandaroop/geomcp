from qgis.core import QgsProject, QgsFillSymbol, QgsLineSymbol

layers = QgsProject.instance().mapLayers()

for layer_id, layer in layers.items():
    if layer.name() == "land":
        # Light beige sandy color for land
        symbol = QgsFillSymbol.createSimple(
            {"color": "#f5deb3", "outline_color": "#d3b896", "outline_width": "0.1"}
        )
        layer.renderer().setSymbol(symbol)
        layer.triggerRepaint()

    elif layer.name() == "lakes":
        # Light blue watery color for lakes
        symbol = QgsFillSymbol.createSimple(
            {"color": "#add8e6", "outline_color": "#5f9ea0", "outline_width": "0.1"}
        )
        layer.renderer().setSymbol(symbol)
        layer.triggerRepaint()

    elif layer.name() == "rivers_lake_centerlines_scale_rank":
        # Darker blue for rivers
        symbol = QgsLineSymbol.createSimple({"color": "#5f9ea0", "width": "0.3"})
        layer.renderer().setSymbol(symbol)
        layer.triggerRepaint()

    elif layer.name() == "admin_0_boundary_lines_land":
        # Gray lines for admin0 boundaries
        symbol = QgsLineSymbol.createSimple({"color": "#606060", "width": "0.5"})
        layer.renderer().setSymbol(symbol)
        layer.triggerRepaint()

    elif layer.name() == "admin_0_boundary_lines_disputed_areas":
        # Gray dashed lines for disputed boundaries
        symbol = QgsLineSymbol.createSimple(
            {"color": "#808080", "width": "0.4", "line_style": "dash"}
        )
        layer.renderer().setSymbol(symbol)
        layer.triggerRepaint()

    elif layer.name() == "admin_1_states_provinces_lines":
        # Lighter gray for admin1 boundaries
        symbol = QgsLineSymbol.createSimple({"color": "#a0a0a0", "width": "0.25"})
        layer.renderer().setSymbol(symbol)
        layer.triggerRepaint()

    # ADD ADDITIONAL LAYER STYLINGS AS NEEDED

result = "Styled all visible layers"
