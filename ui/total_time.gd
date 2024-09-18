extends Label

var lower_bound : int = 0
var upper_bound : int = 50

@export var TIME_PER_PIC : float = 70

func _ready():
    upper_bound = ceili(TIME_PER_PIC * len(Persistence.pics))

func update_timer(remaining_seconds : int):
    self.set_text("%.2f < %.2f < %.2f" % [lower_bound/100.0, remaining_seconds/100.0, upper_bound/100.0])


func _on_timed_button_collector_time_update(total_time : int):
    update_timer(total_time)
