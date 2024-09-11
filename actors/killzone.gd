extends Area2D

@onready var game_over = $GameOver

var is_killing : bool = false

func _on_body_entered(body):
    if body is Pic and not is_killing:
        is_killing = true
        game_over.play()
        get_tree().call_group("pics", "kill")
        await get_tree().create_timer(2).timeout
        is_killing = false
        get_tree().reload_current_scene()

