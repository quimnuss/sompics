extends Node2D
class_name CallDotFalling
@onready var call_dot : CallDot = $CallDot

const FALL_SPEED : float = 200

var call_color : Color

@export var icon_type : CallDot.CallType = CallDot.CallType.CIRCLE

signal picked_up_position(Color, Vector2)

func _ready():
    self.body_entered.connect(_on_body_entered)
    self.add_to_group('calls')
    call_dot.set_type(self.icon_type)
    call_color = call_dot.call_color

func _physics_process(delta):
    self.position += FALL_SPEED * Vector2.DOWN * delta

func _on_body_entered(body : Node2D):
    if body is Pic:
        picked_up_position.emit(self.call_color, self.global_position)
        queue_free()
