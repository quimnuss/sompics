extends Sprite2D

const SPEED : float = -5

func _process(delta):
    region_rect.position.x -= SPEED * delta
