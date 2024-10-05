extends Node2D

@export var spawnable : PackedScene = preload("res://actors/call_dot_falling.tscn")
@onready var spawn_rect := $ReferenceRect
@export var pickup_receiver : Node2D

@export var icon_type : CallDot.CallType = CallDot.CallType.CIRCLE

# returns a local position offset within referencerect
func random_point() -> Vector2:
    var offset : Vector2 = spawn_rect.global_position + spawn_rect.size * Vector2(randf(), randf())
    return offset

func _on_spawn_timer_timeout():
    var spawn : CallDotFalling = spawnable.instantiate()
    spawn.icon_type = icon_type
    spawn.picked_up_position.connect(pickup_receiver._on_picked_position)
    add_child(spawn)
    spawn.global_position = random_point()
