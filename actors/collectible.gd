extends Node2D

@export var collectible_data : CollectibleData
@onready var animation_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
    if OS.is_debug_build() and get_tree().root == get_parent():
        var debug_camera : Camera2D = Camera2D.new()
        debug_camera.position -= Vector2(100,100)
        add_child(debug_camera)
    
    animation_player.play('idle')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass
