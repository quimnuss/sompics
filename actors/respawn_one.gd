extends Area2D

const RESPAWN_WAIT : float = 0.4

func _on_body_entered(body):
    if body is Pic:
        body.drop()
        await get_tree().create_timer(RESPAWN_WAIT).timeout
        body.global_position = owner.get_node('PlayerSpawner').global_position + Vector2(randi_range(-50,50),randi_range(0,50))


    if body is Key and not body.freeze:
        body.call_deferred("set_freeze_enabled", true)
        body.drop()
        # TODO maybe it's better to just reinstantiate
        await get_tree().create_timer(1).timeout
        body.global_position = owner.get_node('KeySpawnerShifter/KeySpawn').global_position
        body.linear_velocity = Vector2.ZERO
        await get_tree().create_timer(0.5).timeout
        body.call_deferred("set_freeze_enabled", false)
