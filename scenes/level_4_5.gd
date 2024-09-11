extends Node2D
@onready var ce = $CE


func _ready():
    Dialogic.timeline_ended.connect(_on_dialogic_timeline_ended)


func _on_dialogic_timeline_ended():
    create_tween().tween_property(ce, "modulate:a", 0.0, 2.0)
