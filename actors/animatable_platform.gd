extends Node2D

@export var offset = Vector2(0, -10)
@export var duration = 5.0

@onready var label = $AnimatableBody2D/Label
@onready var animatable_body_2d : AnimatableBody2D = $AnimatableBody2D

var pics_on_platform : int = 0
@export var required_pics : int = 1

const COYOTE_FRAMES : int = 25
var num_coyote_frame : int = COYOTE_FRAMES

func _ready():
    update_label()

func update_label():
    var missing_pics : int = max(0, required_pics - pics_on_platform)
    label.set_text(str(missing_pics))


func _physics_process(delta):
    if pics_on_platform >= required_pics:
        num_coyote_frame = COYOTE_FRAMES
    else:
        num_coyote_frame -= 1

    if pics_on_platform >= required_pics or num_coyote_frame > 0:
        animatable_body_2d.position = animatable_body_2d.position.move_toward(offset, 40*delta)
    elif position > Vector2.ZERO:
        animatable_body_2d.position = animatable_body_2d.position.move_toward(Vector2.ZERO, 40*delta)


func _on_area_2d_body_entered(body):
    if body is Pic:
        pics_on_platform += 1
        update_label()


func _on_area_2d_body_exited(body):
    if body is Pic:
        pics_on_platform -= 1
        update_label()

