extends Node2D
class_name Door

@onready var door_sprite = $DoorSprite

const level_dir : String = 'res://scenes/'

@export var is_open : bool = false

signal level_exit
signal all_in

var pics_in : int = 0
var num_pics : int = 2

var level_num : int = 0

@export var next_level : String

@export var level_estalvi : int = 10000

func _ready():
    num_pics = len(Persistence.pics)
    if is_open:
        door_sprite.play('open')
    var fullpath : String = get_tree().current_scene.scene_file_path
    var level : String = fullpath.right(7).left(2)
    level_num = int(level)
    if not next_level:
        var next_level_num = level_num+1
        next_level = 'level_' + str(next_level_num) + '.tscn'
        if not ResourceLoader.exists(level_dir + next_level):
            next_level = 'welcome_level.tscn'

func open():
    door_sprite.play('open')
    is_open = true
    Persistence.estalvi(level_estalvi)
    await door_sprite.animation_finished

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
