extends Area2D

@onready var game_over = $GameOver

func _on_body_entered(body):
    if body is Pic:
        game_over.play()
        get_tree().call_group("pics", "kill")
        await get_tree().create_timer(2).timeout
        get_tree().reload_current_scene()

