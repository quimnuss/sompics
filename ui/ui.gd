extends CanvasLayer

@onready var game_lost = $GameLost
@onready var lower_container = $LowerContainer
@onready var friday_label = $FridayLabel

const time_limit_minutes : float = 40
const friday_limit : float = time_limit_minutes*60
const day_limit : float = friday_limit/4
const quarter_day : float = day_limit/4

var days : Array[String] = ['Dilluns', 'Dimarts', 'Dimecres', 'Dijous', 'Divendres', 'Dissabte', 'Diumenge']
var quarters : Array[String] = ['Matinada', 'Matí', 'Tarda', 'Nit']
var quarter_day_count : int = 0
@onready var friday_progress_bar = $FridayLabel/FridayProgressBar


func _on_restart_pressed():
    get_tree().reload_current_scene()


func show_game_lost():
    game_lost.visible = true

func toggle_drback(new_visible : bool):
    lower_container.visible = new_visible

func update_friday():
    var day_num : int = quarter_day_count / 4
    var quarter_day_num : int = quarter_day_count % 4
    var day : String = days[day_num]
    var quarter : String = quarters[quarter_day_num]
    friday_label.text  = '%s %s' % [day, quarter]
    

func _process(delta):
    if OS.is_debug_build():
        $ActivePic.set_text(Persistence.pics[Persistence.active_pic])
    var reminder = fmod(Persistence.elapsed_time, day_limit)/day_limit
    friday_progress_bar.value = reminder*friday_progress_bar.max_value
    var d_quarter_day = quarter_day
    var d_elapsed = Persistence.elapsed_time
    var current_quarter_day : int = Persistence.elapsed_time / quarter_day
    if current_quarter_day > quarter_day_count:
        quarter_day_count = current_quarter_day
        update_friday()
