extends Node2D

const background_music = preload("res://assets/hateno_village.ogg")

func _ready():
    AudioPlayer.crossfade(background_music)
    #AudioPlayer.play_music(background_music)
