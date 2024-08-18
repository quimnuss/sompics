extends CanvasLayer
@onready var game_lost = $GameLost


func _on_restart_pressed():
    get_tree().reload_current_scene()

func show_game_lost():
    game_lost.visible = true

func _process(delta):
    if OS.is_debug_build():
        $ActivePic.set_text(Persistence.pics[Persistence.active_pic])
