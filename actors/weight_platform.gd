extends Node2D

@onready var path_follow_2d = $Path2D/PathFollow2D
@onready var label = $Path2D/PathFollow2D/AnimatableBody2D/Label

var pics_on_platform : int = 0
const SPEED = 50
@export var required_pics : int = 1

func _ready():
    update_label()

func update_label():
    var missing_pics : int = max(0,required_pics - pics_on_platform)
    label.set_text(str(missing_pics))

func _process(delta):
    var current_progress : float = path_follow_2d.get_progress_ratio()
    if pics_on_platform >= required_pics:
        if current_progress < 1:
            current_progress = min(1, current_progress + 0.2*delta)
            path_follow_2d.set_progress_ratio(current_progress)#SPEED * delta)
    elif current_progress > 0:
        current_progress = max(0, current_progress - 0.2*delta)
        path_follow_2d.set_progress_ratio(current_progress)#SPEED * delta)

func _on_area_2d_body_entered(body):
    if body is Pic:
        pics_on_platform += 1
        update_label()

func _on_area_2d_body_exited(body):
    if body is Pic:
        pics_on_platform -= 1
        update_label()
