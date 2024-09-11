extends Node2D

@onready var spawn_timer = $AreaSpawner/SpawnTimer
@onready var door = $Door



func _on_ui_timer_timeout():
    spawn_timer.stop()
    door.open()
