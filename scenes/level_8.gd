extends Node2D

@onready var fueguito_count = $UI/FueguitoCount
@onready var door = $Door

var num_coins: int

func _ready():
    var coins = get_tree().get_nodes_in_group('coins')
    for coin : Coin in coins:
        coin.coin_picked.connect(fueguito_count._on_coin_coin_picked)
        coin.coin_picked.connect(self._on_coin_coin_picked)

    num_coins = len(coins)

func _on_coin_coin_picked():
    num_coins -= 1
    open_door_if_all_coins_picked()

func open_door_if_all_coins_picked():
    if num_coins <= 0:
        door.open()
