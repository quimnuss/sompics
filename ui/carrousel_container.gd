extends HBoxContainer

@export var cards : Array

var visible_index : int = 0

func update():
    var cards = get_children()
    if len(cards) <= 1:
        visible_index = 0
        return
    for card in cards:
        card.visible = false
    visible_index = clamp(visible_index, 0, len(cards)-1)
    $"../LeftButton".disabled = (visible_index == 0)
    $"../RightButton".disabled = (visible_index == len(cards)-1)
    cards[visible_index].visible = true

func _unhandled_input(event):
    if event.is_action_pressed('ui_left'):
        _on_left_pressed()
    elif event.is_action_pressed('ui_right'):
        _on_right_pressed()

func _on_left_pressed():
    visible_index -= 1
    update()


func _on_right_pressed():

    visible_index += 1
    update()
