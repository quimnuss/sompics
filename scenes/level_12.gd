extends Node2D

@onready var tile_map = $TileMap



func _on_button_button_pressed():
    tile_map.set_cells_terrain_connect(0, [Vector2i(14,10)], 0, 2)
    await get_tree().create_timer(0.5).timeout
    tile_map.set_cells_terrain_connect(0, [Vector2i(15,10)], 0, 2)
    await get_tree().create_timer(0.5).timeout
    tile_map.set_cells_terrain_connect(0, [Vector2i(15,9)], 0, 2)
    await get_tree().create_timer(0.5).timeout
    tile_map.set_cells_terrain_connect(0, [Vector2i(15,8)], 0, 2)


func _on_button_2_button_pressed():
    tile_map.set_cells_terrain_connect(0, [Vector2i(20,10)], 0, 2)
    await get_tree().create_timer(0.25).timeout
    tile_map.set_cells_terrain_connect(0, [Vector2i(19,10)], 0, 2)
    await get_tree().create_timer(0.25).timeout
    tile_map.set_cells_terrain_connect(0, [Vector2i(19,9)], 0, 2)
    await get_tree().create_timer(0.25).timeout
    tile_map.set_cells_terrain_connect(0, [Vector2i(19,8)], 0, 2)
