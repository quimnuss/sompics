extends AudioStreamPlayer

const background_music = preload("res://assets/kernel_panic.ogg")

func _ready():
    if !OS.is_debug_build():
        play_music(background_music, -3.0)

func play_music(music : AudioStream, volume = 0.0):
    if stream == music:
        return

    stream = music
    volume_db = volume
    play()

