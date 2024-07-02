extends Node

var pics : Array = ['marta', 'pol']

var active_pic : int = 0

var levels : Array = [true, true, true, true, true, true, true, false]

func _input(event):
    if event.is_action_pressed("switch_pic"):
        active_pic = (active_pic+1)%len(pics)
    elif event.is_action_pressed("level_select"):
        get_tree().change_scene_to_file('res://ui/level_select_menu.tscn')
    elif event.is_action_pressed("quit"):
        get_tree().quit()
