extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass


func _on_body_entered(body):
    if body is Pic:
        body.drop()
        var attached_pic : Pic = body.attached_pic
        body.attached_pic = null
        await get_tree().create_timer(1).timeout
        body.global_position = owner.get_node('PlayerSpawner').global_position
        await get_tree().create_timer(1).timeout
        body.attached_pic = attached_pic

    if body is Key and not body.freeze:
        body.drop()
        body.call_deferred("set_freeze_enabled", true)
        # TODO maybe it's better to just reinstantiate
        await get_tree().create_timer(1).timeout
        body.global_position = owner.get_node('KeySpawn').global_position
        body.call_deferred("set_freeze_enabled", false)
