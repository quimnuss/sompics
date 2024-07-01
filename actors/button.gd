extends Node2D

@onready var off = $Off
@onready var on = $On

signal button_pressed

func _on_area_2d_body_entered(body):
    if body is Pic:
        on.visible = true
        off.visible = false
        button_pressed.emit()
