extends Node2D

@export var timeline : DialogicTimeline = preload("res://dialogs/dr_back_timeline_ending.dtl")

func _ready():
    Dialogic.timeline_ended.connect(_on_dialogic_timeline_ended)

func _on_area_2d_body_entered(body):
    if Dialogic.current_timeline != null:
        return
    get_tree().call_group('pics', 'possess_toggle', false)
    Dialogic.start(timeline)

func _on_dialogic_timeline_ended():
    get_tree().call_group('pics', 'possess_toggle', true)
