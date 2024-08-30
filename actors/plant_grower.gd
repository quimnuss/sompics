extends Node2D

@onready var pot = $Pot

var plant_level_scene : PackedScene = preload("res://actors/plant_level.tscn")

var plant_level : int = 1

const PLANT_OFFSET : int = 16
const MAX_LEVEL : int = 30

func _ready():
    set_level(2)

func set_level(new_level : int):
    for i in range(plant_level, new_level):
        var new_plant_level = plant_level_scene.instantiate()
        pot.add_child(new_plant_level)
        new_plant_level.position.y -= i*PLANT_OFFSET

func add_level():
    if plant_level >= MAX_LEVEL:
        return
    var new_plant_level = plant_level_scene.instantiate()
    pot.add_child(new_plant_level)
    new_plant_level.position.y -= (plant_level+1)*PLANT_OFFSET
    plant_level += 1

func _on_picked(color : Color):
    prints('plant watered with', color)
    if color == CallDot.WATER_COLOR:
        call_deferred('add_level')
