extends Sprite2D

var tween : Tween

@export var vertical_offset = 100

func _ready():
    tween = create_tween().set_loops(500) # there's a spurious error with infinite loops
    tween.tween_property(self, "offset:y", 10, 2).set_ease(Tween.EASE_IN_OUT)
    tween.tween_property(self, "offset:y", 0, 2).set_ease(Tween.EASE_IN_OUT)
    tween.play()
