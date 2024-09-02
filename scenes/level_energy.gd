extends Node2D

@onready var door : Door = $Door
@onready var progress_bar = $Control/VBoxContainer/ProgressBar


func _ready():
    for light : EnergyLight in get_tree().get_nodes_in_group('lights'):
        light.energy_lit.connect(progress_bar._on_point_light_2d_energy_lit)

    give_solar_panels()

func give_solar_panels():
    for pic : Pic in get_tree().get_nodes_in_group('pics'):
        var panel : Sprite2D = Sprite2D.new()
        panel.texture = preload("res://assets/solarpanel.png")
        panel.position += Vector2(20,-10)
        pic.add_child(panel)


func _on_player_spawner_players_spawned():
    give_solar_panels()


func _on_progress_bar_power_up():
    door.open()
