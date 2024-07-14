extends Node2D
class_name TimedButton

@onready var label = $Label

@export var start_time : int = 2*60

const time_warp : float = 15

var remaining_time : float = start_time

var is_timeout : bool = false

signal timeout

func _ready():
    add_to_group('timed_buttons')

func _process(delta):
    if not is_timeout:
        remaining_time -= time_warp*delta
        if remaining_time <= 0:
            remaining_time = 0
            is_timeout = true
            label.set("theme_override_colors/font_color", Color.FIREBRICK)

        var mins : int = remaining_time/60
        var secs : int = fmod(remaining_time,60)
        label.set_text("%02d:%02d" % [mins, secs])

        if is_timeout:
            timeout.emit()
