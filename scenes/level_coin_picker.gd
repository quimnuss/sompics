extends Node2D

@onready var fueguito_count = $UI/FueguitoCount
@onready var door = $Door
@onready var ui_timer = $UI/UITimer
@onready var game_over = $GameOver
@onready var key_spawner = $KeySpawner

var num_coins: int

func _ready():
    var coins = get_tree().get_nodes_in_group('coins')
    for coin : Coin in coins:
        coin.coin_picked.connect(fueguito_count._on_coin_coin_picked)
        coin.coin_picked.connect(self._on_coin_coin_picked)

    num_coins = len(coins)
    fueguito_count.total_coins = num_coins

    var num_pics : int = len(Persistence.pics)
    if num_pics >= 4:
        ui_timer.time_limit = ui_timer.time_limit / 2
    ui_timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
    game_over.play()
    get_tree().call_group('pics', 'kill')
    await get_tree().create_timer(2).timeout
    get_tree().reload_current_scene()

func _on_coin_coin_picked():
    num_coins -= 1
    spawn_key_if_all_coins_picked()

func spawn_key_if_all_coins_picked():
    if num_coins <= 0:
        var key : Key = load('res://actors/key.tscn').instantiate()
        key.global_position = key_spawner.global_position
        call_deferred('add_child', key)
        #door.open()
