extends Control
class_name MoneyUp
@onready var money_up_label = $MoneyUpLabel

@export var estalvi : int

func _ready():
    if estalvi <= 0:
        money_up_label.text = "-%d" % estalvi
        money_up_label.modulate = Color.RED
    else:
        money_up_label.text = "+%d" % estalvi
        money_up_label.modulate = Color.GREEN

    var tween := create_tween()
    tween.tween_property(money_up_label, 'position:y', -50, 1.5)
    tween.parallel().tween_property(money_up_label, 'modulate:a', 0, 1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_EXPO).set_delay(0.5)
    tween.tween_callback(queue_free)

