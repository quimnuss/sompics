extends Node2D

@onready var tile_map = $TileMap

func build_bridge():
    tile_map.set_cells_terrain_connect(0, [Vector2i(23,17)], 0, 0)
    await get_tree().create_timer(1).timeout
    tile_map.set_cells_terrain_connect(0, [Vector2i(22,17)], 0, 0)

func _on_button_button_pressed():
    build_bridge()
