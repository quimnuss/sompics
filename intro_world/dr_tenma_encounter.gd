extends Node

@onready var animation_player = $"../AnimationPlayer"

var dr_back_met : bool = false

func _on_area_2d_body_entered(body):
    if not dr_back_met:
        dr_back_met = true
        get_tree().call_group('pics', 'possess_toggle', false)
        animation_player.play("DrBack")



func _on_animation_player_animation_finished(anim_name):
    if anim_name == 'DrBack':
        get_tree().call_group('pics', 'possess_toggle', true)

func possess_camera():
    ($"../PlayerSpawner" as PlayerSpawner).player_average_position.disconnect($"../PicsCamera"._on_player_spawner_player_average_position)
    get_tree().call_group('pics', 'possess_toggle', false)
