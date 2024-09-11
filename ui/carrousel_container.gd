extends HBoxContainer

@export var cards : Array

var visible_index : int = 0

func update():
    var cards = get_children()
    if cards.is_empty():
        visible_index = 0
        return
    for card in cards:
        card.visible = false
    visible_index = clamp(visible_index, 0, len(cards)-1)
    cards[visible_index].visible = true


func _on_left_pressed():
    visible_index -= 1
    update()


func _on_right_pressed():

    visible_index += 1
    update()
