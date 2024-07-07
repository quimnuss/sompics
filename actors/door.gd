extends Node2D
class_name Door

@onready var door_sprite = $DoorSprite

const level_dir : String = 'res://scenes/'

@export var next_level : String = 'main_level.tscn'

@export var is_open : bool = false

signal level_exit
signal all_in

var pics_in : int = 0
var num_pics : int = 2

func _ready():
    num_pics = len(Persistence.pics)
    if is_open:
        door_sprite.play('open')

func open():
    door_sprite.play('open')
    await door_sprite.animation_finished
    is_open = true

func close():
    is_open = false
    door_sprite.play('close')
    await door_sprite.animation_finished
    door_sprite.play('default')

func pic_exit():
    level_exit.emit()
    pics_in += 1
    if pics_in >= num_pics:
        all_in.emit()
        get_tree().call_deferred('change_scene_to_file',(level_dir + next_level))

func pic_back():
    pics_in -= 1

func _on_area_2d_body_entered(body):
    if body is Key:
        body.use()
        self.open()

    if body is Pic and is_open:
        body.is_on_door = true

func _on_area_2d_body_exited(body):
    if body is Pic and is_open:
        body.is_on_door = false
