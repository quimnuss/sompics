extends Node2D

@export var offset = Vector2(0, -220)
@export var duration = 10.0
@onready var animatable_body_2d = $AnimatableBody2D

func _ready():
    start_tween()

func start_tween():
    var tween = create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
    tween.set_loops().set_parallel(false)
    tween.tween_property(animatable_body_2d, "position", offset, duration / 2)
    tween.tween_property(animatable_body_2d, "position", Vector2.ZERO, duration / 2)
