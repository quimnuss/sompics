extends Node2D


func _ready():
    Persistence.is_friday_counting = false
    var game_beaten = (Persistence.money <= 0)
    Dialogic.VAR.drback_estalviat = game_beaten
