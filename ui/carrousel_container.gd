extends HBoxContainer

@onready var control = $Control

var cards : Array

var visible_index : int = 0

func _ready():
    cards = control.get_children()
    update()


func update():
    for card in cards:
        card.visible = false
    cards[visible_index].visible = true


func _on_left_pressed():
    visible_index = max(0,visible_index-1)
    update()


func _on_right_pressed():
    visible_index = min(len(cards)-1,visible_index+1)
    update()
