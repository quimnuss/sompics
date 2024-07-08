extends HBoxContainer

var coin_count : int = 0
@onready var label = $Label

func _on_coin_coin_picked():
    coin_count += 1
    label.set_text(str(coin_count) + ' fueguitos')
