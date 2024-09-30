extends CanvasModulate


# Called when the node enters the scene tree for the first time.
func _ready():
    get_tree().create_timer(2).timeout.connect(_on_transition_end)

func _on_transition_end():
    get_tree().change_scene_to_file('res://scenes/outro.tscn')
