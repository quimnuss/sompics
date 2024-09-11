extends Node2D

@export var timeline : DialogicTimeline = preload("res://dialogs/dr_back_timeline_ending.dtl")
@onready var collision_shape_2d = $Area2D/CollisionShape2D
@onready var door : Door = $Door
@onready var collectible = $"../Collectible"

@onready var animation_player = $AnimationPlayer
@onready var goose_luis = $GooseLuis

var entered : bool = false
var landed : bool = false

func _ready():
    Dialogic.timeline_ended.connect(_on_dialogic_timeline_ended)


func _input(event):
    if event.is_action_pressed("ui_end"):
        _on_dialogic_timeline_ended()
        Dialogic.clear()


func _on_area_2d_body_entered(body):
    if entered:
        return
    entered = true
    get_tree().call_group('pics', 'possess_toggle', false)
    collision_shape_2d.call_deferred('set_disabled', true)
    animation_player.play("gl_arrival")


func _on_goose_luis_landed():
    if landed:
        return
    landed = true
    print('goose luis landed')
    Dialogic.start(timeline)
    collectible.visible = true


func _on_dialogic_timeline_ended():
    door.open()
    goose_luis.flip_h = true
    animation_player.play_backwards("gl_departure")
    get_tree().call_group('pics', 'possess_toggle', true)
    var foo = Dialogic.VAR
    prints('Accepted GL help?', Dialogic.VAR.goose_luis_help)
    Persistence.goose_luis_help = Dialogic.VAR.goose_luis_help
