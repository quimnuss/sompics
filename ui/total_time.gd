extends Label

var lower_bound : int = 60
var upper_bound : int = 120

func update_timer(remaining_seconds : int):
    var secs : int = remaining_seconds % 60
    var mins : int = remaining_seconds / 60
    self.set_text("%02d:%02d < %02d:%02d < %02d:%02d" % [lower_bound/60, lower_bound%60, mins, secs, upper_bound/60, upper_bound%60])


func _on_timed_button_collector_time_update(total_time : int):
    update_timer(total_time)
