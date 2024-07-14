extends Label

var lower_bound : int = 0
var upper_bound : int = 50

func _ready():
    upper_bound = 40 * len(Persistence.pics)
    
func update_timer(remaining_seconds : int):
    self.set_text("%.2f < %.2f < %.2f" % [lower_bound/100.0, remaining_seconds/100.0, upper_bound/100.0])


func _on_timed_button_collector_time_update(total_time : int):
    update_timer(total_time)
