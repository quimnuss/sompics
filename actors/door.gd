extends Node2D
class_name Door

@onready var door_sprite = $DoorSprite

const level_dir : String = 'res://scenes/'

@export var is_open : bool = false
@export var is_end_level : bool = false

signal door_open
signal level_exit
signal all_in

var pics_in : int = 0
var num_pics : int = 2

var level_num : int = 0

@export var next_level : String

@export var level_estalvi : int = 30000

func _ready():
    num_pics = len(Persistence.pics)
    if is_open:
        door_sprite.play('open')
    var fullpath : String = get_tree().current_scene.scene_file_path
    var level : String = fullpath.get_file()
    var level_index : int = Persistence.level_order.find(level)
    if level_index == -1 or level_index == len(Persistence.level_order)-1:
        push_error(next_level,' not listed. Defaulting to welcome')
        next_level = 'welcome_level.tscn'
    else:
        next_level = Persistence.level_order[level_index+1]
        if not ResourceLoader.exists(level_dir + next_level):
            push_error(next_level,' does not exist. Defaulting to welcome')
            next_level = 'welcome_level.tscn'

    prints(level, '->', next_level)

func open():
    door_sprite.play('open')
    is_open = true
    if not is_end_level:
        Persistence.estalvi(level_estalvi)
    door_open.emit()
    await door_sprite.animation_finished
    if Persistence.goose_luis_help and not is_end_level:
        var anim_player : AnimationPlayer = $CanvasLayer/AnimationPlayer
        anim_player.play('default')
        await anim_player.animation_finished
        Persistence.estalvi(level_estalvi*0.2)

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
