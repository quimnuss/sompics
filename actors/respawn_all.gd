extends Area2D

var is_restarting : bool = false

func _on_body_entered(body):
    if not is_restarting and (body is Pic or body is Key):
        is_restarting = true
        if body is Pic:
            var attached_pics : Array[Pic] = body.attached_pics.duplicate()
            body.attached_pics.clear()
            await get_tree().create_timer(0.2).timeout
            body.drop()
        get_tree().call_group("pics", "kill")
        await get_tree().create_timer(2).timeout
        get_tree().reload_current_scene()
    
