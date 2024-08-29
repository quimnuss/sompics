extends Node2D

@export var call_queue : Array[Color] = [Color.AQUAMARINE, Color.GOLD, Color.FIREBRICK]

var call_queue_dots : Array[CallDot]

const SPACING := 8
const DOT_SIZE := 32
const MAX_DOTS := 10

func add_random_call():
    var color : Color = call_queue.pick_random()
    var dot_index : int = len(call_queue_dots)
    var call_dot : CallDot = preload('res://actors/call_dot.tscn').instantiate()
    call_dot.position.x = (DOT_SIZE + SPACING)*dot_index
    call_dot.modulate = color
    call_queue_dots.append(call_dot)
    add_child(call_dot)

func _on_timer_timeout():
    if len(call_queue_dots) >= MAX_DOTS:
        for dot : CallDot in call_queue_dots:
            dot.queue_free()
        call_queue_dots.clear()
    add_random_call()

