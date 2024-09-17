extends Node2D

@export var spawnable : PackedScene = preload("res://actors/fireworks.tscn")
@onready var spawn_rect := $ReferenceRect
@onready var spawn_timer := $SpawnTimer

# returns a local position offset within referencerect
func random_point() -> Vector2:
    var offset : Vector2 = spawn_rect.global_position + spawn_rect.size * Vector2(randf(), randf())
    return offset

func _on_spawn_timer_timeout():
    var spawn = spawnable.instantiate()
    add_child(spawn)
    spawn.global_position = random_point()

func start():
    spawn_timer.start()
