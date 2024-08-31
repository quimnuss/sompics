extends Node2D

@export var timeline : DialogicTimeline = preload("res://dialogs/dr_back_timeline_ending.dtl")

func _ready():
    Dialogic.timeline_ended.connect(_on_dialogic_timeline_ended)

func _on_area_2d_body_entered(body):
    get_tree().call_group('pics', 'freeze')
    Dialogic.start(timeline)

func _on_dialogic_timeline_ended():
    get_tree().call_group('pics', 'unfreeze')
