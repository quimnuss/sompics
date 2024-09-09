extends Node2D

@export var timeline : DialogicTimeline = preload("res://dialogs/dr_back_timeline_ending.dtl")
@onready var villan_1 = $Villan1
@onready var villan_2 = $Villan1/Villan2
@onready var collision_shape_2d = $Villan1/Area2D/CollisionShape2D
@onready var door : Door = $Door

@export var villan_1_name : String = 'dset'
@export var villan_2_name : String

var entered : bool = false

func _ready():
    Dialogic.timeline_ended.connect(_on_dialogic_timeline_ended)
    villan_1.play(villan_1_name)
    if villan_2_name:
        villan_2.play(villan_2_name)
    else:
        villan_2.hide()
    villan_1.modulate.a = 0

func _input(event):
    if event.is_action_pressed("ui_end"):
        _on_dialogic_timeline_ended()
        Dialogic.clear()

func _on_area_2d_body_entered(body):
    if entered or Dialogic.current_timeline != null:
        return
    entered = true
    get_tree().create_tween().tween_property(villan_1, "modulate:a", 1.0, 2.0)
    get_tree().call_group('pics', 'possess_toggle', false)
    await get_tree().create_timer(2).timeout
    Dialogic.start(timeline)

func _on_dialogic_timeline_ended():
    collision_shape_2d.disabled = true
    door.open()
    get_tree().create_tween().tween_property(villan_1, "modulate:a", 0.0, 2.0)
    get_tree().call_group('pics', 'possess_toggle', true)
    await get_tree().create_timer(2).timeout
    villan_1.queue_free()
