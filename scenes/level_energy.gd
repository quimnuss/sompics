extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


func give_solar_panels():
    for pic : Pic in get_tree().get_nodes_in_group('pics'):
        var panel : Sprite2D = Sprite2D.new()
        pic.add_child(panel)


func _on_player_spawner_players_spawned():
    give_solar_panels()
