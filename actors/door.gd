extends Node2D

@onready var door_sprite = $DoorSprite

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

func open():
    door_sprite.play('open')

func close():
    door_sprite.play('close')
    await door_sprite.animation_finished
    door_sprite.play('default')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass


func _on_area_2d_body_entered(body):
    if body is Key:
        body.use()
        self.open()
