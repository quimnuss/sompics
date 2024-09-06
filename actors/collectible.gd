extends Node2D

@export var collectible_datas : Array[CollectibleData]
@onready var animation_player = $AnimationPlayer
@onready var canvas_layer = $CanvasLayer

@onready var collectible_cards = %CollectibleCards

var fita_consumed = false

func _ready():
    if OS.is_debug_build() and get_tree().root == get_parent():
        var debug_camera : Camera2D = Camera2D.new()
        debug_camera.position -= Vector2(100,100)
        add_child(debug_camera)
    
    canvas_layer.call_deferred('set_visible', false)
    
    from_collectible_data()

func from_collectible_data():
    for collectible_data in collectible_datas:
        var collectible_card : CollectibleCard = preload('res://ui/collectible_card.tscn').instantiate()
        collectible_card.set_data(collectible_data)
        collectible_cards.add_child(collectible_card)

func return_to_game():
    get_tree().call_group('pics', 'possess_toggle', true)
    canvas_layer.visible = false

func _unhandled_input(event):
    if event.is_action_pressed('ui_accept'):
        return_to_game()

func _on_area_2d_body_entered(body):
    if body is Pic and not fita_consumed:
        fita_consumed = true
        animation_player.play('wobble')
        self.modulate.a = 0.2
        canvas_layer.visible = true
        get_tree().call_group('pics', 'possess_toggle', false)

func _on_button_pressed():
    return_to_game()
