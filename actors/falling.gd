extends Node2D
class_name CallDotFalling
@onready var call_dot : CallDot = $CallDot

const FALL_SPEED : float = 200

var call_color : Color

enum CallType {
    CIRCLE,
    CALL,
    CONTRACT,
    PLANT
}

@export var icon_type : CallType = CallType.CIRCLE

signal picked_up(Color)
signal picked_up_position(Color, Vector2)

func _ready():
    self.body_entered.connect(_on_body_entered)
    self.add_to_group('calls')
    call_dot.set_type(self.icon_type)
    call_color = call_dot.call_color

func _physics_process(delta):
    self.position += FALL_SPEED * Vector2.DOWN * delta

func estalvi_popup():
    match icon_type:
        CallType.CONTRACT:
            if call_color != Color.FIREBRICK:
                var money_up : MoneyUp = load("res://ui/money_up.tscn").instantiate()
                money_up.estalvi = 3000
                get_parent().add_child(money_up)
                money_up.global_position = self.global_position
            else:
                var money_up : MoneyUp = load("res://ui/money_up.tscn").instantiate()
                money_up.estalvi = -2000
                get_parent().add_child(money_up)
                money_up.global_position = self.global_position

func _on_body_entered(body : Node2D):
    if body is Pic:
        picked_up.emit(self.call_color)
        estalvi_popup()
        queue_free()
