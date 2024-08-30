extends Node2D
class_name CallDotFalling

const FALL_SPEED : float = 200

signal picked_up

func _ready():
    self.body_entered.connect(_on_body_entered)

func _physics_process(delta):
    self.position += FALL_SPEED * Vector2.DOWN * delta

func _on_body_entered(body : Node2D):
    if body is Pic:
        picked_up.emit()
        queue_free()
