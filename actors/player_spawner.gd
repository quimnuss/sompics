extends Marker2D

@export var attached : bool = false
@onready var wscontroller : WsController = $WebsocketMinimalController

var pic_scene = preload('res://actors/pic.tscn')

var last_pic : Pic

func _ready():
    var pics_array = Persistence.pics
    for pic_name in pics_array:
        await get_tree().create_timer(1.0).timeout
        if attached:
            spawn_attached(pic_name)
        else:
            spawn(pic_name)

func spawn(pic_name : String):
    #TODO prevent spawning inside the collider OR posess characters manually placed on level OR activate collisions with other players when not colliding
    var pic : Pic = pic_scene.instantiate()
    pic.person = pic_name
    self.add_child(pic)
    var controller : WsController = wscontroller
    controller.action_received.connect(pic.external_input)

func spawn_attached(pic_name):
    var pic : Pic = pic_scene.instantiate()
    pic.person = pic_name
    self.add_child(pic)
    await get_tree().create_timer(1.0).timeout
    if last_pic:
        pic.attach(last_pic)
    last_pic = pic




