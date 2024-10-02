extends Node2D
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var player_spawner = $PlayerSpawner
@onready var ui = $UI
@onready var tile_map = $TileMap

var restarting : bool = false
const background_music = preload("res://assets/hollow_knight_sealed_vessel.ogg")

var players_ready : bool = false

func _ready():
    for pic : Pic in get_tree().get_nodes_in_group('pics'):
        pic.gravity = 0
    player_spawner.players_spawned.connect(set_players_ready)
    ui.toggle_drback(false)

    AudioPlayer.crossfade(background_music)
    if Persistence.is_first_time_level_18:
        Persistence.is_first_time_level_18 = false
        animation_player.play("first_level_pursuit")
    else:
        player_spawner.players_spawned.connect(start_level)

func set_players_ready():
    players_ready = true

func start_level():
    animation_player.play("level_pursuit")

func fill_hole_instant():
    var hole_coords : Array[Vector2i] = []
    for i in range(41):
        hole_coords.append(Vector2i(16,i))

    tile_map.set_cells_terrain_connect(2, hole_coords, 0, 1)

func fill_hole():
    $FloorBreakSound.play()
    for i in range(41):
        tile_map.set_cells_terrain_connect(2, [Vector2i(16,i)], 0, 1)
        await get_tree().create_timer(0.1).timeout
    $FloorBreakSound.stop()

func _on_collided():
    if not restarting:
        animation_player.pause()
        restarting = true
        get_tree().call_group('pics', 'kill')

        await get_tree().create_timer(2).timeout
        var foo = get_tree()
        foo.reload_current_scene()


func _on_wall_left_body_entered(body):
    if body is Pic:
        _on_collided()


func _on_area_2d_body_entered(body):
    if body is Pic:
        _on_collided()
