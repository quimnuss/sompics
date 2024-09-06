extends Node2D

@export var collectible_data : CollectibleData
@onready var animation_player = $AnimationPlayer
@onready var canvas_layer = $CanvasLayer

var fita_consumed = false

func _ready():
    if OS.is_debug_build() and get_tree().root == get_parent():
        var debug_camera : Camera2D = Camera2D.new()
        debug_camera.position -= Vector2(100,100)
        add_child(debug_camera)
    
    animation_player.play('idle')
    canvas_layer.call_deferred('set_visible', false)

func _on_area_2d_body_entered(body):
    if body is Pic and not fita_consumed:
        fita_consumed = true
        canvas_layer.visible = true
        get_tree().call_group('pics', 'possess_toggle', false)

func _on_button_pressed():
    get_tree().call_group('pics', 'possess_toggle', true)
    canvas_layer.visible = false
