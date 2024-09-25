extends Node

#var pics : Array = []
var pics : Array = [
    #'marta',
    'pol',
    #'joana', 'juanpe',
    #'david',
    #'marite',
    #'isra',
    #'daniestanyol',
    'xavidolz',
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
]

const possible_pics : Array = [
    'marta',
    'pol',
    'joana',
    'juanpe',
    'david',
    'marite',
    'isra',
    'daniestanyol',
    'xavidolz',
    'benjami',
    'nuse',
    'fran',
    'jordi',
    'joan',
    'raul',
    'lucia',
    'pere',
    'bea',
    'angel',
    'oriol',
    'xavierbonet',
    'daniquilez'
]

var active_pic : int = 0

var ce_members : Array[String] = ['juanpe', 'xavierbonet', 'benjami', 'daniquilez']

var levels : Array = [
    true, true, true, true, true, true, true, true, true, true,
    true, true, true, true, true, true, true, true, true, false
]

var level_order : Array[String] = [
    'welcome_level.tscn',
    'intro_world_medieval.tscn',
    'level_0.tscn',
    'level_1.tscn',
    'level_1_5.tscn',
    'level_2.tscn',
    'level_3.tscn',
    'level_3_5.tscn',
    'level_4.tscn',
    'level_4_5.tscn',
    'level_5.tscn',
    'level_6.tscn',
    'level_6_5.tscn',
    'level_7.tscn',
    'level_8.tscn',
    'level_8_5.tscn',
    'level_9.tscn',
    'level_9_5.tscn',
    'level_10.tscn',
    'level_11.tscn',
    'level_12.tscn',
    'level_12_5.tscn',
    'level_13.tscn',
    'level_13_5.tscn',
    'level_14.tscn',
    'level_15.tscn',
    'level_15_5.tscn',
    'level_16.tscn',
    'level_16_5.tscn',
    'level_17.tscn',
    'level_17_5.tscn',
    'level_18.tscn',
    'outro.tscn',
]

var is_friday_counting : bool = false
const friday_limit_minutes : int = 40
const friday_limit : int = friday_limit_minutes*60
var elapsed_time : float = 0

var money : int = 900000 :
    set(value):
        money = value
        money_changed.emit()
    get:
        return money

const LISTEN_PORT : int = 9080

var goose_luis_help : bool = false

signal money_changed

func estalvi(value : int):
    money -= value
    money = clamp(money, 0, 1000000)

func _input(event):
    if event.is_action_pressed("switch_pic"):
        active_pic = (active_pic+1)%len(pics)
    elif event.is_action_pressed("level_select"):
        get_tree().change_scene_to_file('res://ui/level_select_menu.tscn')
    elif event.is_action_pressed("quit"):
        get_tree().quit()

func _process(delta):
    if is_friday_counting:
        elapsed_time += delta
