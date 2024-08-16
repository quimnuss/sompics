extends Node2D

@export var offset = Vector2(0, -10)
@export var duration = 5.0

@onready var label = $AnimatableBody2D/Label

var pics_on_platform : int = 0
@export var required_pics : int = 1

var tween : Tween

func _ready():
    start_tween()
    update_label()

func start_tween():
    tween = get_tree().create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
    tween.set_loops().set_parallel(false)
    tween.tween_property($AnimatableBody2D, "position", offset, duration / 2)
    tween.tween_property($AnimatableBody2D, "position", Vector2.ZERO, duration / 2)


func update_label():
    var missing_pics : int = max(0, required_pics - pics_on_platform)
    label.set_text(str(missing_pics))


func _on_area_2d_body_entered(body):
    if body is Pic:
        pics_on_platform += 1
        update_label()
        if pics_on_platform >= required_pics:
            tween.play()


func _on_area_2d_body_exited(body):
    if body is Pic:
        pics_on_platform -= 1
        update_label()
        if pics_on_platform <= required_pics:
            tween.pause()
