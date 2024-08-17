extends Node2D

@export var offset = Vector2(0, -10)
@export var duration = 5.0

@onready var label = $AnimatableBody2D/Label
@onready var animatable_body_2d : AnimatableBody2D = $AnimatableBody2D

var pics_on_platform : int = 0
@export var required_pics : int = 1

var coyote : bool = false


func _ready():
    update_label()

func update_label():
    var missing_pics : int = max(0, required_pics - pics_on_platform)
    label.set_text(str(missing_pics))

const COYOTE_FRAMES = 20
var current_coyote_frames = COYOTE_FRAMES

func _physics_process(delta):
    if pics_on_platform < required_pics:
        current_coyote_frames = max(0, current_coyote_frames - 1)
    else:
        current_coyote_frames = COYOTE_FRAMES

    if pics_on_platform >= required_pics or current_coyote_frames > 0:
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

