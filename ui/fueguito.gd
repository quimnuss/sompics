extends HBoxContainer

var coin_count : int = 0
@onready var label = $Label

var total_coins : int = 60

func _ready():
    call_deferred('count_coins')

func count_coins():
    if is_instance_valid(get_tree()):
        total_coins = len(get_tree().get_nodes_in_group('coins'))

func _on_coin_coin_picked():
    coin_count += 1
    label.set_text(str(coin_count) + '/' + str(total_coins) + ' fueguitos')
