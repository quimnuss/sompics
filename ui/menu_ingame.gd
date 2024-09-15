extends Button

@export var scene_filename = "res://ui/level_menu.tscn"

func _on_pressed():
    get_tree().change_scene_to_file(scene_filename)
