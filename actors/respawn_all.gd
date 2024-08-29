extends Area2D


func _on_body_entered(body):
    if body is Pic:
        var attached_pics : Array[Pic] = body.attached_pics.duplicate()
        body.attached_pics.clear()
        await get_tree().create_timer(0.2).timeout
        body.drop()
        get_tree().call_group("pics", "kill")
        await get_tree().create_timer(2).timeout
        get_tree().reload_current_scene()

        #body.global_position = owner.get_node('PlayerSpawner').global_position + Vector2(randi_range(-50,50),randi_range(-50,50))
        #await get_tree().create_timer(0.25).timeout
        #body.attached_pics = attached_pics

    if body is Key and not body.freeze:
        body.call_deferred("set_freeze_enabled", true)
        body.drop()
        # TODO maybe it's better to just reinstantiate
        await get_tree().create_timer(1).timeout
        body.global_position = owner.get_node('KeySpawnerShifter/KeySpawn').global_position
        body.linear_velocity = Vector2.ZERO
        await get_tree().create_timer(0.5).timeout
        body.call_deferred("set_freeze_enabled", false)
