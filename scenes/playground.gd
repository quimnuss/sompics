extends Node2D

@onready var tile_map = $TileMap

func _ready():
    $EvilBeePath/EvilBeeFollowPath.rotates = false
    $EvilBeePath/EvilBeeFollowPath/EvilBee/Body.rotation = PI


func build_bridge():
    for i in range(4):
        tile_map.set_cells_terrain_connect(0, [Vector2i(23-i,15)], 0, 2)
        await get_tree().create_timer(1).timeout

func _input(event):
    if Input.is_action_just_pressed('special'):
        get_tree().call_group('pics','kill')


func _on_button_button_pressed():
    build_bridge()
