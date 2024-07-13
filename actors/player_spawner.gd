extends Marker2D

@export var attached : bool = false
#@onready var wscontroller : WsController = $WebsocketMinimalController
var wscontroller : WsController

var pic_scene = preload('res://actors/pic.tscn')

var last_pic : Pic

signal player_average_position(avg_position)

func _ready():
    wscontroller = WsController.new()
    self.add_child(wscontroller)
    var pics_array = Persistence.pics
    for pic_name in pics_array:
        await get_tree().create_timer(0.5).timeout
        if attached:
            spawn_attached(pic_name)
        else:
            spawn(pic_name)

    for pic : Pic in get_tree().get_nodes_in_group('pics'):
        pic.pic_back.connect($"../Door".pic_back)
        pic.pic_exit.connect($"../Door".pic_exit)

func spawn(pic_name : String):
    #TODO prevent spawning inside the collider OR posess characters manually placed on level OR activate collisions with other players when not colliding
    var pic : Pic = pic_scene.instantiate()
    pic.person = pic_name
    self.add_child(pic)
    if not wscontroller:
        wscontroller = WsController.new()
        add_child(wscontroller)
    wscontroller.action_received.connect(pic.external_input)

func spawn_attached(pic_name):
    var pic : Pic = pic_scene.instantiate()
    pic.person = pic_name
    self.add_child(pic)
    await get_tree().create_timer(1.0).timeout
    if last_pic:
        pic.attach(last_pic)
        last_pic.attach(pic)
    last_pic = pic

func _process(delta):
    var pics : Array = get_tree().get_nodes_in_group('pics')
    if len(pics) == 0:
        return
    var avg_pic_position : Vector2 = Vector2(0,0)
    for pic : Pic in pics:
        avg_pic_position += pic.global_position
    avg_pic_position = avg_pic_position/len(pics)
    player_average_position.emit(avg_pic_position)
        
