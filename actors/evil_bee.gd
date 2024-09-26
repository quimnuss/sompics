extends Area2D

@export var keyspawn : Node2D
@onready var animation_player = $AnimationPlayer
@onready var idle_sound = $IdleSound
@onready var hit_sound = $HitSound
@onready var body = $Body

const RESPAWN_WAIT : float = 2 # should be equal or greater than pic kill animation

var respawning_pics : Array[Pic]

func _ready():
    animation_player.play("idle_right")
    idle_sound.play()

func set_flip(new_flip : bool):
    #body.flip_v = new_flip
    body.flip_h = new_flip

func _on_body_entered(body):
    
    if body is Pic and body not in respawning_pics:
        var pic : Pic = body as Pic
        respawning_pics.push_back(body)
        pic.drop()
        hit_sound.play()
        #var tween = create_tween()
        #tween.tween_property(pic.body, 'rotation', 10*PI, RESPAWN_WAIT).set_ease(Tween.EASE_OUT).from(0)
        #tween.play()
        body.kill()
        await get_tree().create_timer(RESPAWN_WAIT).timeout
        pic.revive()
        pic.global_position = owner.get_node('PlayerSpawner').global_position + Vector2(randi_range(-50,50),randi_range(0,50))
        #pic.body.set_rotation(0)
        respawning_pics.pop_front()
        
