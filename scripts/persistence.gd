extends Node

var pics : Array = ['marta', 'pol']

var active_pic : int = 0

func _input(event):
    if event.is_action_pressed("switch_pic"):
        active_pic = (active_pic+1)%len(pics)
