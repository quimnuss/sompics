extends Control

var SPEED : int = 40

func _process(delta):
    self.position.y -= delta*SPEED
