extends Node2D
@onready var animation_player : AnimationPlayer = $AnimationPlayer

var restarting : bool = false

func _ready():
    animation_player.play("level_pursuit")
    for pic : Pic in get_tree().get_nodes_in_group('pics'):
        pic.gravity = 0

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
