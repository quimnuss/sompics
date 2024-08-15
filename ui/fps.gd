extends Label


func _process(_delta: float) -> void:
    text = "%s FPS" % [Engine.get_frames_per_second()]
