extends Node2D

@onready var label : Label = $Label

var num_pics : int = 0

func _on_pic_counter_body_entered(body):
    if body is Pic:
        num_pics += 1
        label.text = str(len(Persistence.pics) - num_pics)


func _on_pic_counter_body_exited(body):
    if body is Pic:
        num_pics -= 1
        label.text = str(len(Persistence.pics) - num_pics)
