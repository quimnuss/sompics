extends Node2D
class_name FakeDoor

@onready var door_sprite = $DoorSprite

signal fake_open

func _ready():
    pass

func fakeopen():
    door_sprite.play('fakeopen')
    await door_sprite.animation_finished

func _on_area_2d_body_entered(body):
    if body is Key:
        #body.use()
        self.fakeopen()
