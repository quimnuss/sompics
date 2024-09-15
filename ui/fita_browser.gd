extends Node

@export var collectible_datas : Array[CollectibleData]

@onready var collectible_cards = %CollectibleCards

func _ready():
    for collectible_data in collectible_datas:
        var collectible_card : CollectibleCard = preload('res://ui/collectible_card.tscn').instantiate()
        collectible_card.set_data(collectible_data)
        collectible_cards.add_child(collectible_card)
    collectible_cards.update()


func _on_button_pressed():
    get_tree().change_scene_to_file("res://ui/level_menu.tscn")
