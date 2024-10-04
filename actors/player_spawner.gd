extends Marker2D
class_name PlayerSpawner

@onready var markers_node = get_node_or_null('./Markers')

@export var attached : bool = false
#@onready var wscontroller : WsController = $WebsocketMinimalController
#var wscontroller : WsController

@export var rigipics_spawn : bool = false
@export var is_gravity_on : bool = true
@export var spawn_delay : float = 0.15
@export var spawn_half_range : Vector2 = Vector2(70, 50)

var pic_scene := preload('res://actors/pic.tscn')
var ripic_scene := preload('res://actors/rigipic.tscn')

var spawned_pics := 0

var last_pic : Pic

signal player_average_position(avg_position)

signal players_spawned

func _ready():
    #wscontroller = WsController.new()
    #self.add_child(wscontroller)

    var markers = markers_node.get_children() if markers_node else Array()

    var pics_array = Persistence.pics

    for pic_name in pics_array:
        await get_tree().create_timer(spawn_delay).timeout
        if attached:
            spawn_attached(pic_name)
        elif not markers.is_empty():
            var index : int = pics_array.find(pic_name)
            if markers[index%len(markers)] is Marker2D:
                spawn_at(pic_name, markers[index].global_position)
            else:
                spawn(pic_name)
        elif not is_gravity_on:
            spawn_flying(pic_name)
        else:
            spawn(pic_name)

    players_spawned.emit()

    for pic in get_tree().get_nodes_in_group('pics'):
        var door : Door = get_node_or_null("../Door")
        if door:
            pic.pic_back.connect(door.pic_back)
            pic.pic_exit.connect(door.pic_exit)

func spawn_one(pic_name : String):
    var markers = markers_node.get_children() if markers_node else Array()
    var pics_array = Persistence.pics

    if attached:
        spawn_attached(pic_name)
    elif not markers.is_empty():
        var index : int = pics_array.find(pic_name)
        if markers[index%len(markers)] is Marker2D:
            spawn_at(pic_name, markers[index].global_position)
        else:
            spawn(pic_name)
    elif not is_gravity_on:
        spawn_flying(pic_name)
    else:
        spawn(pic_name)

    for pic in get_tree().get_nodes_in_group('pics'):
        if pic.person == pic_name:
            var door : Door = get_node_or_null("../Door")
            if door:
                door.num_pics += 1
                if not pic.pic_back.is_connected(door.pic_back):
                    pic.pic_back.connect(door.pic_back)
                if not pic.pic_exit.is_connected(door.pic_exit):
                    pic.pic_exit.connect(door.pic_exit)

func despawn(pic : Pic):
    pic.queue_free()
    var door : Door = get_node_or_null("../Door")
    if door:
        door.num_pics -= 1

func spawn_at(pic_name : String, spawn_point : Vector2):
    var pic = ripic_scene.instantiate() if rigipics_spawn else pic_scene.instantiate()
    pic.person = pic_name
    self.add_child(pic)
    pic.global_position = spawn_point


func spawn(pic_name : String):
    #TODO prevent spawning inside the collider OR posess characters manually placed on level OR activate collisions with other players when not colliding
    var pic = ripic_scene.instantiate() if rigipics_spawn else pic_scene.instantiate()
    pic.person = pic_name
    pic.position += Vector2(randf_range(-spawn_half_range.x,spawn_half_range.x),randf_range(-spawn_half_range.y,spawn_half_range.y))
    self.add_child(pic)


func spawn_flying(pic_name : String):
    var pic = ripic_scene.instantiate() if rigipics_spawn else pic_scene.instantiate()
    pic.person = pic_name
    if not is_gravity_on:
        pic.set_is_flying()
        @warning_ignore("integer_division")
        var shift_spawn : Vector2 = spawned_pics%6 * Vector2(50,0) + spawned_pics/6 * Vector2(0, 50)
        pic.position += shift_spawn
        spawned_pics += 1

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


func _process(_delta):
    var pics : Array = get_tree().get_nodes_in_group('pics')
    if len(pics) == 0:
        return
    var avg_pic_position : Vector2 = Vector2(0,0)
    var max_pic_position : Vector2 = pics[0].global_position
    var min_pic_position : Vector2 = pics[0].global_position
    for pic in pics:
        max_pic_position.x = maxf(max_pic_position.x, pic.global_position.x)
        min_pic_position.x = minf(min_pic_position.x, pic.global_position.x)
    avg_pic_position = (max_pic_position + min_pic_position)/2
    player_average_position.emit(avg_pic_position)

