extends Node2D
class_name FakeDoor

@onready var door_sprite = $DoorSprite
@onready var audio_stream_player = $AudioStreamPlayer

var is_tried : bool = false

signal fake_open

func _ready():
    pass

func fakeopen():
    is_tried = true
    door_sprite.play('fakeopen')
    audio_stream_player.play()
    if is_tried:
        fake_open.emit()
    await door_sprite.animation_finished

func _on_area_2d_body_entered(body):
    if body is Key:
        #body.use()
        self.fakeopen()
