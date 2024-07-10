extends Node2D

class_name Coin
@onready var collision_shape_2d = $Area2D/CollisionShape2D

signal coin_picked

var is_picked : bool = false

func _ready():
    add_to_group('coins')

func _on_area_2d_body_entered(body):
    if body is Pic and not is_picked:
        is_picked = true
        coin_picked.emit()
        queue_free()
