extends Node2D

@onready var tile_map = $TileMap

func _ready():
    var initial_bridge_tiles : Array[Vector2i];
    var num_pics : int = len(Persistence.pics)
    var length : int = max(0, 9 - floor(num_pics/2.0))
    for i in range(length):
        for j in range(2):
            initial_bridge_tiles.push_back(Vector2i(10+i,17+j))

    tile_map.set_cells_terrain_connect(0, initial_bridge_tiles, 0, 2)

func build_bridge():
    for i in range(9):
        tile_map.set_cells_terrain_connect(0, [Vector2i(23-i,17)], 0, 2)
        await get_tree().create_timer(0.5).timeout

func _on_button_button_pressed():
    build_bridge()
