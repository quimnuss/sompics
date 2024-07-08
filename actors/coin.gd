extends Node2D

class_name Coin

signal coin_picked

func _ready():
    add_to_group('coins')

func _on_area_2d_body_entered(body):
    if body is Pic:
        coin_picked.emit()
        queue_free()
