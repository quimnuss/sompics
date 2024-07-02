extends RigidBody2D

@onready var collision_shape_2d = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass


func _on_area_2d_body_entered(body):
    if body is Pic:
        await get_tree().create_timer(0.4).timeout
        self.set_sleeping(false)
        self.call_deferred("set_freeze_enabled", false)
        collision_shape_2d.disabled = true
