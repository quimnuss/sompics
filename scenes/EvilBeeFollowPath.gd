extends PathFollow2D

var speed = 0.2
var reverse_speed = -0.2
var target = 0.99

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    bouncing_movement(delta)


func loop_movement(delta):
    progress_ratio += delta * speed


func bouncing_movement(delta):
    if progress_ratio < target:
        progress_ratio += delta * speed
        target = 0.99
    if progress_ratio > target:
        target = 0.01
        progress_ratio += delta * reverse_speed
