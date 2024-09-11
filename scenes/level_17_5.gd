extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
    var game_beaten = (Persistence.money > 0)
    Dialogic.VAR.drback_estalviat = game_beaten


