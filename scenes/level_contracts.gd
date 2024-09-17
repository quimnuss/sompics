extends Node2D

@onready var spawn_timer = $AreaSpawner/SpawnTimer
@onready var door = $Door
@onready var animation_player = $AnimationPlayer

func _ready():
    Persistence.money_changed.connect(_on_money_changed)

func _on_money_changed():
    if Persistence.money <= 0:
        animation_player.play('drback_defeated')


func _on_ui_timer_timeout():
    spawn_timer.stop()
    door.open()
