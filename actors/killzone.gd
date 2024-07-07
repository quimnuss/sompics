extends Area2D


func _on_body_entered(body):
    if body is Pic:
        get_tree().call_group("pics", "kill")
        await get_tree().create_timer(1).timeout
        get_tree().reload_current_scene()

