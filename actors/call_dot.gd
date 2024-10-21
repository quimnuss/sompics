extends Node2D
class_name CallDot

const WATER_COLOR : Color = Color.AQUAMARINE
const BAD_CONTRACT : Color = Color.FIREBRICK

@export var call_queue : Array[Color] = [Color.AQUAMARINE, Color.GOLD, Color.FIREBRICK]

@export var icon_type : CallType = CallType.CALL

var selected_sprite : Sprite2D

enum CallType {
    CIRCLE,
    CALL,
    CONTRACT,
    PLANT
}

var call_color : Color

var sprite_anim_tween : Tween

@export var anim_fps : float = 15.0

func _ready():
    call_color = call_queue.pick_random()
    self.modulate = call_color

    animate()

func set_type(new_icon_type : CallType):
    sprite_anim_tween.kill()
    icon_type = new_icon_type
    animate()

func animate():

    selected_sprite = $Sprite2D
    $CallIcon.visible = false
    $Sprite2D.visible = false
    $PlantIcon.visible = false
    $ContractIcon.visible = false
    match icon_type :
        CallType.CALL:
            selected_sprite = $CallIcon
        CallType.CONTRACT:
            selected_sprite = $ContractIcon
        CallType.PLANT:
            selected_sprite = $PlantIcon
        _:
            selected_sprite = $Sprite2D
    selected_sprite.visible = true
    var num_frames : int = selected_sprite.hframes * selected_sprite.vframes
    var duration : float = float(num_frames)/anim_fps
    if num_frames > 1:
        sprite_anim_tween = create_tween().set_loops()
        sprite_anim_tween.tween_property(selected_sprite, 'frame', num_frames-1, duration).from(0)
