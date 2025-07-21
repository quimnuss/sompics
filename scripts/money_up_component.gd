extends Node2D
class_name MoneyUpComponent


func _ready():
	if get_parent().has_signal('has_estalvied'):
		get_parent().has_estalvied.connect(_on_estalvi)


func _on_estalvi(amount : int):
	var money_up : MoneyUp = load("res://ui/money_up.tscn").instantiate()
	money_up.estalvi = amount
	add_child(money_up)
