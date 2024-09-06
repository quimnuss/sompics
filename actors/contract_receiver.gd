extends Node2D


func _on_picked(color : Color):
    if color != CallDot.BAD_CONTRACT:
        Persistence.estalvi(1000)
    else:
        Persistence.estalvi(-1000)
