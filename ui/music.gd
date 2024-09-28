extends Button


func _on_toggled(toggled_on):
    if not toggled_on:
        AudioPlayer.resume_play()
    else:
        AudioPlayer.stop()
