extends Node

const background_music = preload("res://assets/kernel_panic.ogg")
@onready var track_1 = $Track1
@onready var track_2 = $Track2

var is_demo : bool = true

var is_on_track_1 : bool = true

func _ready():
    if !OS.is_debug_build() or is_demo:
        play_music(background_music, -10.0)

func play_music(music : AudioStream, volume = -6.0):

    if track_1.stream == music:
        return

    is_on_track_1 = true
    stop()
    track_1.stream = music
    track_1.volume_db = volume
    track_1.play()

func crossfade(music : AudioStream, volume = -6.0):
    var fade_out_track : AudioStreamPlayer = track_1 if is_on_track_1 else track_2
    var fade_in_track : AudioStreamPlayer = track_2 if is_on_track_1 else track_1
    if fade_out_track.stream == music:
        return
    is_on_track_1 = not is_on_track_1
    fade_in_track.stream = music
    fade_in_track.volume_db = -90
    var tween = create_tween()
    tween.tween_property(fade_out_track, 'volume_db', -90, 6).set_trans(Tween.TRANS_EXPO)
    tween.parallel().tween_property(fade_in_track, 'volume_db', volume, 6).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
    tween.tween_callback(fade_out_track.stop)
    fade_in_track.play()

func resume_play():
    if is_on_track_1:
        track_1.play()
    else:
        track_2.play()

func stop():
    track_1.stop()
    track_2.stop()

func fade_out():
    var fade_out_track : AudioStreamPlayer = track_1 if is_on_track_1 else track_2
    var tween = create_tween()
    tween.tween_property(fade_out_track, 'volume_db', -90, 6).set_trans(Tween.TRANS_EXPO)
    tween.tween_callback(fade_out_track.stop)
