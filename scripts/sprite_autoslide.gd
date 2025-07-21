extends Sprite2D

@export var speed : Vector2 = Vector2(-5,0)


func _physics_process(delta):
	region_rect.position -= speed * delta
