extends Node2D

@onready var good_pickup_sound = $GoodPickupSound
@onready var bad_pickup_sound = $BadPickupSound


func _on_picked(color : Color):
    if color != CallDot.BAD_CONTRACT:
        good_pickup_sound.play()
        Persistence.estalvi(3000)
    else:
        bad_pickup_sound.play()
        Persistence.estalvi(-2000)
