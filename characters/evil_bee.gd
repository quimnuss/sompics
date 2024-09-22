extends Area2D

@export var keyspawn : Node2D

const RESPAWN_WAIT : float = 0.4

var respawning_pics : Array[Pic]

# Called when the node enters the scene tree for the first time.
func _ready():
    $AnimatedSprite2D.play("idle_right")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass


func _on_body_entered(body):
    
    if body is Pic and body not in respawning_pics:
        respawning_pics.push_back(body)
        body.drop()
        # TODO tween rotation
        await get_tree().create_timer(RESPAWN_WAIT).timeout
        body.global_position = owner.get_node('PlayerSpawner').global_position + Vector2(randi_range(-50,50),randi_range(0,50))
        respawning_pics.pop_front()


    if body is Key and not body.freeze:
        body.call_deferred("set_freeze_enabled", true)
        body.drop()
        # TODO maybe it's better to just reinstantiate
        await get_tree().create_timer(1).timeout
        if not is_instance_valid(keyspawn):
            keyspawn = owner.get_node('KeySpawn')

        body.global_position = keyspawn.global_position
        body.linear_velocity = Vector2.ZERO
        await get_tree().create_timer(0.5).timeout
        body.call_deferred("set_freeze_enabled", false)

