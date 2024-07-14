extends Node2D
@onready var label = $Label

@export var start_time : int = 5*60

const time_warp : float = 10

var remaining_time : float = start_time

func _ready():
    add_to_group('timed_buttons')

func _process(delta):
    remaining_time -= time_warp*delta
    var mins : int = remaining_time/60
    var secs : int = fmod(remaining_time,60)
    label.set_text("%02d:%02d" % [mins, secs])
