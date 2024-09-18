extends PanelContainer

@onready var label : Label = $Label

@export var time_limit : float = 60

var elapsed_time = 0

var finishing : bool = false

var is_halted : bool = false

signal timeout

func update_timer(remaining_seconds : int):
    @warning_ignore("integer_division")
    var secs : int = remaining_seconds % 60
    var mins : int = remaining_seconds / 60
    label.set_text("%02d:%02d" % [mins, secs])

func _process(delta):
    if finishing or is_halted:
        return

    elapsed_time += delta
    var remaining_secs = ceil(time_limit - elapsed_time)
    if remaining_secs <= 0:
        timeout.emit()
        remaining_secs = 0
        finishing = true

    update_timer(remaining_secs)

func halt():
    is_halted = true

func resume():
    is_halted = false
