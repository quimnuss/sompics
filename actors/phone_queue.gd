extends Node2D
@onready var good_pickup_sound = $GoodPickupSound
@onready var bad_pickup_sound = $BadPickupSound

var call_queue_dots : Array[CallDot]

const SPACING := 8
const DOT_SIZE := 32
const MAX_DOTS := 10

func add_random_call():
    var dot_index : int = len(call_queue_dots)
    var call_dot : CallDot = preload('res://actors/call_dot.tscn').instantiate()
    call_dot.position.x = (DOT_SIZE + SPACING)*dot_index
    call_queue_dots.append(call_dot)
    add_child(call_dot)

func picked_correct_call():
    good_pickup_sound.play()
    var a_call : CallDot = call_queue_dots.pop_front()
    a_call.queue_free()
    for call_dot : CallDot in call_queue_dots:
        call_dot.position.x -= DOT_SIZE + SPACING
    if call_queue_dots.is_empty():
        Persistence.estalvi(3000)
    else:
        Persistence.estalvi(300)

func picked_wrong_call(color):
    bad_pickup_sound.play()
    Persistence.estalvi(-300)

func clear():
    for dot : CallDot in call_queue_dots:
        dot.queue_free()
    call_queue_dots.clear()

func _on_timer_timeout():
    if len(call_queue_dots) >= MAX_DOTS:
        Persistence.estalvi(-3000)
        for dot : CallDot in call_queue_dots:
            dot.queue_free()
        call_queue_dots.clear()
    add_random_call()

func _on_picked(color : Color):
    if not call_queue_dots.is_empty():
        var call_dot = call_queue_dots[0]
        if not is_instance_valid(call_dot):
            return
        if call_dot.modulate == color:
            picked_correct_call()
        else:
            picked_wrong_call(color)
