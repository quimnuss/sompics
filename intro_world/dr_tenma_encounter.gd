extends Node

@onready var animation_player = $"../AnimationPlayer"
@onready var player_spawner = $"../PlayerSpawner"
@onready var pics_camera = $"../PicsCamera"

const level_dir : String = 'res://scenes/'

var dr_back_met : bool = false

func _on_area_2d_body_entered(_body):
    start_dr_back_encounter()

func start_dr_back_encounter():
    if not dr_back_met:
        dr_back_met = true
        get_tree().call_group('pics', 'possess_toggle', false)
        animation_player.play("DrBack")

func _on_animation_player_animation_finished(anim_name):
    if anim_name == 'DrBack':
        get_tree().call_group('pics', 'possess_toggle', true)

func possess_camera():
    player_spawner.player_average_position.disconnect(pics_camera._on_player_spawner_player_average_position)
    get_tree().call_group('pics', 'possess_toggle', false)

func to_welcome_level():
    var next_level = 'welcome_level.tscn'
    var fullpath : String = get_tree().current_scene.scene_file_path
    var level : String = fullpath.get_file()
    var level_index : int = Persistence.level_order.find(level)
    if level_index == -1 or level_index == len(Persistence.level_order)-1:
        push_error(next_level,' not listed. Defaulting to welcome')
    else:
        next_level = Persistence.level_order[level_index+1]
        if not ResourceLoader.exists(level_dir + next_level):
            push_error(next_level,' does not exist. Defaulting to welcome')
            next_level = 'welcome_level.tscn'

    prints(level, '->', next_level)
    get_tree().change_scene_to_file(level_dir + next_level)
