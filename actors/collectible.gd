extends Node2D

@export var collectible_datas : Array[CollectibleData]
@onready var animation_player = $AnimationPlayer
@onready var canvas_layer = $CanvasLayer
@onready var sprite_anchor = $Anchor
@onready var card_sprite := $Anchor/CardSprite

@onready var collectible_cards = %CollectibleCards

var fita_consumed = false

signal picked_up
signal resume_game
signal has_estalvied(amount : int)

var estalvi_amount : int = 1000

func _ready():
	if OS.is_debug_build() and get_tree().root == get_parent():
		var debug_camera : Camera2D = Camera2D.new()
		debug_camera.position -= Vector2(100,100)
		add_child(debug_camera)

	canvas_layer.call_deferred('set_visible', false)

	from_collectible_data()

	fita_consumed = is_consumed()
	if fita_consumed:
		visually_consumed()

func visually_consumed():
	sprite_anchor.modulate.a = 0.2

func is_consumed():
	for collectible_data in collectible_datas:
		if collectible_data.title not in Persistence.consumed_fites:
			return false
	return true

func from_collectible_data():
	var team : String = collectible_datas[0].team if not collectible_datas.is_empty() else 'all'
	for collectible_data in collectible_datas:
		var collectible_card : CollectibleCard = preload('res://ui/collectible_card.tscn').instantiate()
		collectible_card.set_data(collectible_data)
		collectible_cards.add_child(collectible_card)
		if team != 'all' and team != collectible_data.team:
			team = 'all'

	collectible_cards.update()
	if len(collectible_datas) <= 1:
		$CanvasLayer/MarginContainer/VBoxContainer/HBoxContainer/LeftButton.queue_free()
		$CanvasLayer/MarginContainer/VBoxContainer/HBoxContainer/RightButton.queue_free()

	match team:
		'Dades':
			card_sprite.frame = 1
		'ERP':
			card_sprite.frame = 2
		'Webapps':
			card_sprite.frame = 4
		'Suport':
			card_sprite.frame = 3
		_:
			card_sprite.frame = 0

func return_to_game():
	get_tree().call_group('pics', 'possess_toggle', true)
	canvas_layer.visible = false
	resume_game.emit()

func _unhandled_input(event):
	if event.is_action_pressed('ui_accept'):
		return_to_game()

func _on_area_2d_body_entered(body):
	if body is Pic and not fita_consumed:
		fita_consumed = true
		for collectible_data in collectible_datas:
			Persistence.add_fita(collectible_data)
		animation_player.play('wobble')
		visually_consumed()
		get_tree().call_group('pics', 'possess_toggle', false)
		picked_up.emit()
		Persistence.estalvi(estalvi_amount)
		has_estalvied.emit(estalvi_amount)
		await get_tree().create_timer(1).timeout
		canvas_layer.visible = true

func _on_button_pressed():
	return_to_game()
