extends Node2D

@onready var phone_queue = $Tomatic/PhoneQueue

func _ready():
    var calls = get_tree().get_nodes_in_group('calls')
    for call : CallDotFalling in calls:
        call.picked_up.connect(phone_queue._on_call_picked)
