extends Node2D

@export var spawnable : PackedScene = preload("res://actors/call_dot_falling.tscn")
@onready var spawn_rect := $ReferenceRect
@onready var phone_queue = $"../Tomatic/PhoneQueue"

# returns a local position offset within referencerect
func random_point() -> Vector2:
    var offset : Vector2 = spawn_rect.global_position + spawn_rect.size * Vector2(randf(), randf())
    return offset

func _on_spawn_timer_timeout():
    var spawn : CallDotFalling = spawnable.instantiate()
    spawn.picked_up.connect(phone_queue._on_call_picked)
    add_child(spawn)
    spawn.global_position = random_point()
