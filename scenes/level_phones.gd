extends Node2D

@onready var phone_queue = $Tomatic/PhoneQueue
@onready var spawn_timer = $AreaSpawner/SpawnTimer
@onready var timer = $Tomatic/PhoneQueue/Timer
@onready var door = $Door

func _ready():
    var calls = get_tree().get_nodes_in_group('calls')
    for call : CallDotFalling in calls:
        call.picked_up.connect(phone_queue._on_call_picked)


func _on_ui_timer_timeout():
    spawn_timer.stop()
    timer.stop()
    door.open()
    phone_queue.clear()

