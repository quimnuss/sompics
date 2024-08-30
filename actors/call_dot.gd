extends Node2D
class_name CallDot

@export var call_queue : Array[Color] = [Color.AQUAMARINE, Color.GOLD, Color.FIREBRICK]

var call_color : Color

func _ready():
    call_color = call_queue.pick_random()
    self.modulate = call_color
