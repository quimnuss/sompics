extends Node2D
class_name CallDotFalling
@onready var call_dot : CallDot = $CallDot

const FALL_SPEED : float = 200

var call_color : Color

signal picked_up(Color)

func _ready():
    self.body_entered.connect(_on_body_entered)
    self.add_to_group('calls')
    call_color = call_dot.call_color

func _physics_process(delta):
    self.position += FALL_SPEED * Vector2.DOWN * delta

func _on_body_entered(body : Node2D):
    if body is Pic:
        picked_up.emit(self.call_color)
        queue_free()
