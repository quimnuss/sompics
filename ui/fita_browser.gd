extends Control

@export var collectible_datas : Array[CollectibleData]

@onready var collectible_cards = %CollectibleCards
@onready var flow_container = %FlowContainer
@onready var fita_carrousel = $FitaCarrousel

func _ready():
    for collectible_data in collectible_datas:
        var collectible_card : CollectibleCard = preload('res://ui/collectible_card.tscn').instantiate()
        collectible_card.set_data(collectible_data)
        collectible_cards.add_child(collectible_card)
        var fitabox : FitaBox = preload('res://ui/fitabox.tscn').instantiate()
        var is_consumed : bool = collectible_data.title in Persistence.consumed_fites
        fitabox.pressed.connect(popup_carrousel)
        flow_container.add_child(fitabox)
        fitabox.setup(collectible_data.title, collectible_data.team, is_consumed)
    collectible_cards.update()

func popup_carrousel(fita_name):
    collectible_cards._on_fita_selected(fita_name)
    fita_carrousel.visible = true


func _on_button_pressed():
    get_tree().change_scene_to_file("res://ui/level_menu.tscn")


func _on_back_button_pressed():
    fita_carrousel.visible = false
