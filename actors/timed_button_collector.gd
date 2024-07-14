extends Node2D

var total_time : int = 0

signal time_update(total_time)
signal time_up

func _process(delta):
    var previous_total_time : int = total_time
    total_time = 0
    for timed_button in get_tree().get_nodes_in_group('timed_buttons'):
        total_time += timed_button.remaining_time
    if previous_total_time != total_time:
        time_update.emit(total_time)
    if total_time == 0:
        time_up.emit()
