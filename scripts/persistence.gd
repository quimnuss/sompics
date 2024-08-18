extends Node

#var pics : Array = []
var pics : Array = [
    'marta', 'pol'
]
    #'marta', 'pol', 'joana', 'juanpe'
#]
    #'marta',
    #'pol',
    #'david',
    #'juanpe',
    #'joana',
    #'marite',
    #'isra',
    #'daniestanyol',
    #'xavidolz',
    #'benjami',
    #'nuse',
    #'fran',
    #'jordi',
    #'joan',
    #'raul',
    #'lucia',
    #'pere',
    #'bea',
    #'angel',
    #'oriol',
    #'xavierbonet',
    #'daniquilez'
#]

var active_pic : int = 0

var levels : Array = [
    true, true, true, true, true, true, true, true, true, true,
    true, true, true, true, false
]

const LISTEN_PORT : int = 9080

func _input(event):
    if event.is_action_pressed("switch_pic"):
        active_pic = (active_pic+1)%len(pics)
    elif event.is_action_pressed("level_select"):
        get_tree().change_scene_to_file('res://ui/level_select_menu.tscn')
    elif event.is_action_pressed("quit"):
        get_tree().quit()
