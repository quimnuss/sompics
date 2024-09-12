extends Node2D

@onready var animation_player = $AnimationPlayer
@onready var typing_animation = $TypingAnimation

@export var ce_prisoner : String = 'juanpe'
@onready var head : Head = $Head

@export var CE_FREE_ESTALVI : int = 6000
@onready var freedom_announcement = $FreedomAnnouncement
@onready var head_pick_collision = $Head/Area2D/HeadPickCollision


func _ready():
    freedom_announcement.text = freedom_announcement.text % ce_prisoner

    head.set_person(ce_prisoner)

    var animations : PackedStringArray = typing_animation.sprite_frames.get_animation_names()
    var animation : String = animations[randi() % len(animations)]
    typing_animation.play(animation)


func open():
    animation_player.play('free_ce')


func _on_button_button_pressed():
    open()


func _on_area_2d_body_entered(body):
    if body is Pic:
        head_pick_collision.call_deferred("set_disabled", true)
        prints(ce_prisoner,'is Free')
        animation_player.play('reposess_ce')
        var ce_member_idx : int = Persistence.ce_members.find(ce_prisoner)
        if ce_member_idx != -1:
            Persistence.ce_members.remove_at(ce_member_idx)
        Persistence.estalvi(CE_FREE_ESTALVI)
        var pic_idx : int = Persistence.pics.find(ce_prisoner)
        if pic_idx != -1:
            for pic : Pic in get_tree().get_nodes_in_group('pics'):
                if pic.person == ce_prisoner:
                    pic.unghost()
                    break

