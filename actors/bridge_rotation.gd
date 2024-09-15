extends Sprite2D


func lower_bridge():
    var tween : Tween = create_tween()
    tween.tween_property(self, "rotation", 0, 4)


