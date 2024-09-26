extends Control

var SPEED : int = 50

func _process(delta):
    self.position.y -= delta*SPEED
