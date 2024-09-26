extends PathFollow2D

var speed = 0.2
var reverse_speed = -0.2
var target = 0.99
@onready var actor = $EvilBee


func _process(delta):
    loop_movement(delta)


func loop_movement(delta):
    progress_ratio = fmod(progress_ratio + delta * speed,1)
    var is_flipped : bool = progress_ratio < 0.5
    actor.set_flip(is_flipped)


func bouncing_movement(delta):
    if progress_ratio < target:
        progress_ratio += delta * speed
        target = 0.99
    if progress_ratio > target:
        target = 0.01
        progress_ratio += delta * reverse_speed
