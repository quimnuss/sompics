extends RigidBody2D

@onready var collision_shape_2d = $CollisionShape2D

@export var drop_wait = 0.7

func _on_area_2d_body_entered(body):
    if body is Pic:
        await get_tree().create_timer(drop_wait).timeout
        self.set_sleeping(false)
        self.call_deferred("set_freeze_enabled", false)
        #collision_shape_2d.disabled = true
