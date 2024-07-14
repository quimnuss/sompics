extends CanvasLayer
@onready var game_lost = $GameLost


func _on_restart_pressed():
    get_tree().reload_current_scene()

func show_game_lost():
    game_lost.visible = true
