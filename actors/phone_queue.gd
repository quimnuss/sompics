extends Node2D

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
    print('correct!')
    var call : CallDot = call_queue_dots.pop_front()
    call.queue_free()
    for call_dot : CallDot in call_queue_dots:
        call_dot.position.x -= DOT_SIZE + SPACING
    if call_queue_dots.is_empty():
        Persistence.estalvi(1000)
    else:
        Persistence.estalvi(100)

func picked_wrong_call(color):
    prints('wrong! expected',call_queue_dots[0].modulate,'got',color)
    Persistence.estalvi(-100)

func clear():
    for dot : CallDot in call_queue_dots:
        dot.queue_free()
    call_queue_dots.clear()

func _on_timer_timeout():
    if len(call_queue_dots) >= MAX_DOTS:
        Persistence.estalvi(-1000)
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
