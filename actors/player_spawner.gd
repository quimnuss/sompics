extends Marker2D

@export var attached : bool = false
#@onready var wscontroller : WsController = $WebsocketMinimalController
#var wscontroller : WsController

@export var rigipics_spawn : bool = false
@export var is_gravity_on : bool = true

var pic_scene = preload('res://actors/pic.tscn')
var ripic_scene = preload('res://actors/rigipic.tscn')

var last_pic : Pic

signal player_average_position(avg_position)

func _ready():
    #wscontroller = WsController.new()
    #self.add_child(wscontroller)
    var pics_array = Persistence.pics
    for pic_name in pics_array:
        await get_tree().create_timer(0.25).timeout
        if attached:
            spawn_attached(pic_name)
        else:
            spawn(pic_name)

    for pic in get_tree().get_nodes_in_group('pics'):
        pic.pic_back.connect($"../Door".pic_back)
        pic.pic_exit.connect($"../Door".pic_exit)

var shift_spawn : Vector2 = Vector2.ZERO

func spawn(pic_name : String):
    #TODO prevent spawning inside the collider OR posess characters manually placed on level OR activate collisions with other players when not colliding
    var pic = ripic_scene.instantiate() if rigipics_spawn else pic_scene.instantiate()
    pic.person = pic_name
    if not is_gravity_on:
        pic.is_flying = true
        pic.position += shift_spawn
        shift_spawn += Vector2(50,0)
    self.add_child(pic)

func spawn_attached(pic_name):
    var pic : Pic = pic_scene.instantiate()
    pic.person = pic_name
    self.add_child(pic)
    await get_tree().create_timer(1.5).timeout
    if last_pic:
        pic.attach(last_pic)
        last_pic.attach(pic)
        prints(pic.person,'--',last_pic.person)
    last_pic = pic

func _process(delta):
    var pics : Array = get_tree().get_nodes_in_group('pics')
    if len(pics) == 0:
        return
    var avg_pic_position : Vector2 = Vector2(0,0)
    for pic in pics:
        avg_pic_position += pic.global_position
    avg_pic_position = avg_pic_position/len(pics)
    player_average_position.emit(avg_pic_position)

