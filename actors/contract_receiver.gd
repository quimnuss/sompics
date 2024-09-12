extends Node2D


func _on_picked(color : Color):
    if color != CallDot.BAD_CONTRACT:
        Persistence.estalvi(3000)
    else:
        Persistence.estalvi(-2000)
