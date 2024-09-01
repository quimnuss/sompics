extends Node

class_name ShakeComponent

var current_shake = 0

@export var sprite: Node2D
@export var shake_amount: = 5.0
@export var shake_duration: = 0.5

# warning, it will not handle window resizing
var original_position : Vector2 = Vector2.ZERO

func _ready():
    # does not work if a parent changes it's position (e.g. like a container)
    # it can probably be fixed by setget position
    original_position = get_parent().position

func _on_trigger_shake():
    current_shake = shake_amount
    pass

func _physics_process(delta: float) -> void:
    if OS.is_debug_build() and Input.is_action_just_pressed("ui_text_submit"):
        _on_trigger_shake()

    if current_shake == 0:
        return

    current_shake -= shake_amount * delta / shake_duration
    if current_shake < 0:
        current_shake = 0
        get_parent().position = original_position

    get_parent().position = original_position + Vector2(randf_range(-current_shake, current_shake), randf_range(-current_shake, current_shake))
