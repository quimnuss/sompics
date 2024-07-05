extends Path2D

@onready var follow_path = $PathFollow2D

const SPEED : int = 50

var direction : int = 1

func _process(delta):
    var current_progress : float = follow_path.get_progress_ratio()
    if current_progress >= 1:
        direction = -1
    elif current_progress <= 0:
        direction = 1

    follow_path.set_progress(follow_path.get_progress() + delta*SPEED*direction)
