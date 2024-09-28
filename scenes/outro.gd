extends Node2D

const background_music = preload("res://assets/hollow_knight_city_of_tears.ogg")

func _ready():
    AudioPlayer.crossfade(background_music)

