extends RigidBody2D

@onready var collision_shape_2d = $CollisionShape2D


func _on_area_2d_body_entered(body):
    if body is Pic:
        await get_tree().create_timer(0.4).timeout
        self.set_sleeping(false)
        self.call_deferred("set_freeze_enabled", false)
        collision_shape_2d.disabled = true
