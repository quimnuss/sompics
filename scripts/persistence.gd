extends Node

#var pics : Array = []
var pics : Array = [
    'marta',
    'pol',
    #'gil',
    #'diego',
    #'angel',
    #'bea',
    #'benjami',
    #'daniestanyol',
    #'daniquilez',
    #'david',
    #'fran',
    #'isra',
    #'javi',
    #'jimena',
    #'joan',
    #'joana',
    #'jordi',
    #'juanpe',
    #'lucia',
    #'marite',
    #'oriol',
    #'pau',
    #'pere',
    #'raul',
    #'rogerlapena',
    #'rogersanjaume',
    #'xavidolz',
    #'xavierbonet',
]

const possible_pics : Array = [
    'marta',
    'pol',
    'gil',
    'diego',
    'angel',
    'bea',
    'benjami',
    'daniestanyol',
    'daniquilez',
    'david',
    'fran',
    'isra',
    'javi',
    'jimena',
    'joan',
    'joana',
    'jordi',
    'juanpe',
    'lucia',
    'marite',
    'oriol',
    'pau',
    'pere',
    'raul',
    'rogerlapena',
    'rogersanjaume',
    'xavidolz',
    'xavierbonet',
]

var active_pic : int = 0

var ce_members : Array[String] = ['juanpe', 'xavierbonet', 'benjami', 'daniquilez']

var levels : Array = [
    true, true, true, true, true, true, true, true, true, true,
    true, true, true, true, true, true, true, true, true, false
]

var level_order : Array[String] = [
    'welcome_level.tscn',
    'disclaimer.tscn',
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

var consumed_fites : Array[String]

var is_friday_counting : bool = false
const friday_limit_minutes : int = 40
const friday_limit : int = friday_limit_minutes*60
var elapsed_time : float = 0
var is_first_time_level_18 : bool = true

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

func _ready():
    #load_game()
    pass

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

func add_fita(fita : CollectibleData):
    if fita.title not in consumed_fites:
        consumed_fites.append(fita.title)
        save_game()

const SAVEFILE : String = "user://sompics_savegame.save"

func save_game():
    var save_file = FileAccess.open(SAVEFILE, FileAccess.WRITE)
    var game_state_dict : Dictionary = {'fites': consumed_fites}
    game_state_dict['money'] = money
    var json_string = JSON.stringify(game_state_dict)
    save_file.store_line(json_string)

func load_game():
    if not FileAccess.file_exists(SAVEFILE):
        return
    var save_file = FileAccess.open(SAVEFILE, FileAccess.READ)
    var json_string = save_file.get_line()
    var json = JSON.new()
    var parse_result = json.parse(json_string)
    if not parse_result == OK:
        print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
        return
    var saved_data = json.get_data()
    var savegame_fites = saved_data.get('fites',[])
    Persistence.consumed_fites.append_array(savegame_fites)
    Persistence.money = saved_data.get('money', money)
