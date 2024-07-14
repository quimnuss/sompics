extends Node2D

@onready var area_2d = $Area2D

var last_pushing : int = 0

func _physics_process(delta):
    var overlapping_bodies = area_2d.get_overlapping_areas()
    if last_pushing != len(overlapping_bodies):
        last_pushing = len(overlapping_bodies)
