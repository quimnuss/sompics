extends Node2D

@onready var tile_map = $TileMap/PlayWorld

var length : int

const MAX_LENGTH : int = 5

func _ready():
    var initial_bridge_tiles : Array[Vector2i] = []
    var num_pics : int = len(Persistence.pics)
    length = max(0, MAX_LENGTH - floor(num_pics/2.0))
    for i in range(length):
        for j in range(2):
            initial_bridge_tiles.push_back(Vector2i(14+i,18+j))

    tile_map.set_cells_terrain_connect(initial_bridge_tiles, 0, 2)

func build_bridge():
    for i in range(max(MAX_LENGTH - length + 1,0)):
        tile_map.set_cells_terrain_connect([Vector2i(23-i,18)], 0, 2)
        await get_tree().create_timer(0.5).timeout

func _on_button_button_pressed():
    build_bridge()
