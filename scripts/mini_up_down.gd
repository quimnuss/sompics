extends PointLight2D

var flip : bool = true
var elapsed : float = 0

func _process(delta):
    elapsed += delta
    if elapsed >= 0.25:
        elapsed -= 0.25
        global_position.y += 2 if flip else -2

        flip = not flip
