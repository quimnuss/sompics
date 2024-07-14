extends Node2D

var total_time : int = 0

signal time_update(total_time)
signal time_up
signal all_stopped(total_time)

func _ready():
    for timed_button : TimedButton in get_tree().get_nodes_in_group('timed_buttons'):
        timed_button.timeout.connect(somebody_timeout)
        timed_button.stopped.connect(somebody_stopped)
        
func somebody_timeout():
    time_up.emit()

func aggregate_time():
    total_time = 0
    for timed_button in get_tree().get_nodes_in_group('timed_buttons'):
        total_time += timed_button.remaining_time

func somebody_stopped():
    var all_are_stopped = true
    for timed_button : TimedButton in get_tree().get_nodes_in_group('timed_buttons'):
        if timed_button.is_running:
            all_are_stopped = false
    if all_are_stopped:
        self.set_process(false)
        aggregate_time()
        all_stopped.emit(self.total_time)
        if all_stopped.get_connections():
            all_stopped.disconnect(all_stopped.get_connections()[0]['callable'])

func _process(delta):
    var previous_total_time : int = total_time
    aggregate_time()
    if previous_total_time != total_time:
        time_update.emit(total_time)
    if total_time == 0:
        time_up.emit()
