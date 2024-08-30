extends Node2D
class_name CallDot

@export var call_queue : Array[Color] = [Color.AQUAMARINE, Color.GOLD, Color.FIREBRICK]

func _ready():
    var color : Color = call_queue.pick_random()
    self.modulate = color
