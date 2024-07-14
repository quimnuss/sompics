extends Node2D

@onready var ui = $UI
@onready var ui_total_time = $UI/TotalTime
@onready var key_spawn = $KeySpawn


func _on_timed_button_collector_time_up():
    game_lost_restart()

func game_lost_restart():
    ui.show_game_lost()
    await get_tree().create_timer(2).timeout
    get_tree().reload_current_scene()


func _on_timed_button_collector_all_stopped(total_time : int):
    if ui_total_time.lower_bound <= total_time and total_time <= ui_total_time.upper_bound:
        var key = load("res://actors/key.tscn").instantiate()
        key.global_position = key_spawn.global_position
        add_child(key)
    else:
        game_lost_restart()
