extends Control

const background_music = preload("res://assets/hollow_knight_fungal_wastes.ogg")

func _ready():
    AudioPlayer.crossfade(background_music)
