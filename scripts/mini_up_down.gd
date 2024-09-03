extends PointLight2D

var flip : bool = true
var elapsed : float = 0

func _ready():
    self.energy = 0.1

func set_light_level(light_level : int):
    self.energy = light_level

func _process(delta):
    elapsed += delta
    if elapsed >= 0.25:
        elapsed -= 0.25
        global_position.y += 2 if flip else -2

        flip = not flip
