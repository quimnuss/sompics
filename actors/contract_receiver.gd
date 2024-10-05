extends Node2D

@onready var good_pickup_sound = $GoodPickupSound
@onready var bad_pickup_sound = $BadPickupSound

func popup_estalvi(amount : int, coords : Vector2):
    var money_up : MoneyUp = load("res://ui/money_up.tscn").instantiate()
    money_up.estalvi = amount
    self.add_child(money_up)
    money_up.global_position = coords

func _on_picked_position(color : Color, coords : Vector2):
    if color != CallDot.BAD_CONTRACT:
        good_pickup_sound.play()
        Persistence.estalvi(3000)
        popup_estalvi(3000, coords)
    else:
        bad_pickup_sound.play()
        Persistence.estalvi(-2000)
        popup_estalvi(-2000, coords)
