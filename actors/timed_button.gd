extends Node2D
class_name TimedButton

@onready var label = $Label

@export var start_time : int = 1000

const time_warp : float = 100

var remaining_time : float = start_time

var is_timeout : bool = false
var is_running : bool = true

signal timeout
signal stopped

func _ready():
    add_to_group('timed_buttons')

func _process(delta):
    if not is_timeout and is_running:
        remaining_time -= time_warp*delta
        if remaining_time < 1:
            remaining_time = 0
            is_timeout = true
            label.set("theme_override_colors/font_color", Color.FIREBRICK)

        label.set_text("%.2f" % [remaining_time/100.0])

        if is_timeout:
            timeout.emit()


func _on_button_button_pressed():
    is_running = false
    stopped.emit()
