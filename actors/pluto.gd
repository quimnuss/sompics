extends Node2D

@onready var label : Label = $Label
@onready var sprite_2d : Sprite2D = $Sprite2D
@export var wrong1_text : String = "Ha ha ha!\nSabia que no teníen ni idea d'on desplegueu!\nNo arribareu a productiu abans de divendres!"
@export var wrong2_text : String = "Ha ha ha!\nNi a la segona!\nAra segur que no arribareu\na productiu abans de divendres!"
@export var right_text : String = "Grrr!\nNo m'esperava que\nsapiguéssiu on deployeu..."
@export var wrong_penalty : int = 2000

var tries_count : int = 0
var is_open : bool = false
var label_text : String

var tried_doors : Array[int] = []

func _ready():
    label_text = label.text

func wrong_door():
    if is_open:
        return
    if tries_count == 0:
        tries_count += 1
        label.text = wrong1_text
    else:
        label.text = wrong2_text
    Persistence.money += wrong_penalty
    await get_tree().create_timer(3).timeout
    label.text = label_text

func right_door():
    is_open = true
    label.text = right_text
    sprite_2d.tween.stop()

func _on_fake_door_fake_open():
    if tried_doors.find(1) == -1:
        tried_doors.push_back(1)
        wrong_door()

func _on_fake_door_2_fake_open():
    if tried_doors.find(2) == -1:
        tried_doors.push_back(2)
        wrong_door()

func _on_door_door_open():
    right_door()
