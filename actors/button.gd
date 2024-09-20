extends Node2D

@onready var off = $Off
@onready var on = $On

var is_pressed : bool = false

signal button_pressed

func _on_area_2d_body_entered(body):
    if not is_pressed and body is Pic:
        is_pressed = true
        on.visible = true
        off.visible = false
        button_pressed.emit()
