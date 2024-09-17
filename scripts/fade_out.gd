extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready():
    var tween = create_tween()
    tween.tween_property(self, 'modulate:a', 0, 10).set_ease(Tween.EASE_IN)
    tween.finished.connect(_on_tween_finished)

func _on_tween_finished():
    queue_free()


