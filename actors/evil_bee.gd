extends PathFollow2D

var speed = 0.2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	loop_movement(delta)

func loop_movement(delta):
	progress_ratio += delta * speed
