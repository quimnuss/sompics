extends Node2D

@onready var label : Label = $Label
@onready var bridge = $Bridge

var num_pics : int = 0

signal pics_in_bridge

func _ready():
    label.text = str(len(Persistence.pics))

func _on_pic_counter_body_entered(body):
    if body is Pic:
        num_pics += 1
        var missing_pics : int = len(Persistence.pics) - num_pics
        label.text = str(missing_pics)
        if missing_pics <= 0:
            pics_in_bridge.emit()


func _on_pic_counter_body_exited(body):
    if body is Pic:
        num_pics -= 1
        label.text = str(len(Persistence.pics) - num_pics)
