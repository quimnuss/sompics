extends Node2D

@onready var ui = $UI


func _on_timed_button_collector_time_up():
    ui.show_game_lost()
    await get_tree().create_timer(2).timeout
    get_tree().reload_current_scene()
