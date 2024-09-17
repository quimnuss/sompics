extends Node2D

@onready var rocket = $Rocket
@onready var explosion = $Explosion

var colors : Array[Color] = [Color.WHITE, Color.DARK_RED, Color.DARK_GOLDENROD, Color.DARK_GREEN]

var textures : Array[Texture] = [
    preload("res://assets/fireworks/Explosion_Default_Orange-sheet.png"),
    preload("res://assets/fireworks/Explosion_Default_Blue-sheet.png")
]

func _ready():
    var color : Color = colors.pick_random()
    explosion.texture = textures.pick_random()
    var height : float = randf_range(150,300)
    var explosion_scale : float = randf_range(2,4)
    explosion.scale = Vector2(explosion_scale, explosion_scale)
    #rocket.modulate = color
    #explosion.modulate = color
    explosion.modulate.a = 0
    var tween1 : Tween = create_tween()
    var tween2 : Tween = create_tween()
    tween1.tween_property(self, 'position:y',-height, 1)
    tween2.tween_property(rocket, 'frame', rocket.hframes-1, 1)
    tween1.tween_property(rocket, 'modulate:a', 0, 0.1)
    tween2.tween_property(explosion, 'modulate:a', 1, 0.1)
    tween1.tween_property(explosion, 'frame', explosion.hframes-1, 3)
    tween1.tween_property(explosion, 'modulate:a', 0, 0.1)
    tween1.tween_callback(queue_free)
    
