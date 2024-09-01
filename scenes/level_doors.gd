extends Node2D

@onready var fake_door = $FakeDoor
@onready var fake_door_2 = $FakeDoor2
@onready var door = $Door


func _ready():
    var door_position : int = randi_range(0,2)
    match door_position:
        0:
            var aux_pos = fake_door.global_position
            fake_door.global_position = door.global_position
            door.global_position = aux_pos
        2:
            var aux_pos = fake_door.global_position
            fake_door.global_position = door.global_position
            door.global_position = aux_pos

