extends Sprite2D


func _ready():
    var num_frames : int = self.hframes*self.vframes
    var tween = get_tree().create_tween().set_loops()
    tween.tween_property(self, "frame", num_frames-1, (num_frames-1)*0.1).from(0)

