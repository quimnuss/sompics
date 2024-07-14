extends Node2D

var total_time : int = 0

signal time_update(total_time)

func _process(delta):
    total_time = 0
    for timed_button in get_tree().get_nodes_in_group('timed_buttons'):
        total_time += timed_button.remaining_time
