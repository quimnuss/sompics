extends Node2D

@onready var fueguito_count = $UI/FueguitoCount
@onready var door = $Door
@onready var ui_timer = $UI/UITimer

var num_coins: int

func _ready():
    var coins = get_tree().get_nodes_in_group('coins')
    for coin : Coin in coins:
        coin.coin_picked.connect(fueguito_count._on_coin_coin_picked)
        coin.coin_picked.connect(self._on_coin_coin_picked)

    num_coins = len(coins)

    ui_timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
    get_tree().call_group('pics', 'kill')
    await get_tree().create_timer(2).timeout
    get_tree().reload_current_scene()

func _on_coin_coin_picked():
    num_coins -= 1
    open_door_if_all_coins_picked()

func open_door_if_all_coins_picked():
    if num_coins <= 0:
        door.open()
