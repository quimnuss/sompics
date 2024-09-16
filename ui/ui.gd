extends CanvasLayer

@onready var game_lost = $GameLost
@onready var lower_container = $LowerContainer
@onready var friday_container = $FridayContainer


func _on_restart_pressed():
    get_tree().reload_current_scene()


func show_game_lost():
    game_lost.visible = true


func toggle_drback(new_visible : bool):
    lower_container.visible = new_visible


func _process(delta):
    $ActivePic.set_text(Persistence.pics[Persistence.active_pic])
    
    if Persistence.is_friday_counting and Persistence.elapsed_time > Persistence.friday_limit:
        friday_container.visible = true
        Persistence.is_friday_counting = false
