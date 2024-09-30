extends Label

@onready var friday_container := $"../FridayContainer"
@onready var friday_progress_bar := $FridayProgressBar

@onready var previous_day := $DayChange/PreviousDay
@onready var next_day := $DayChange/NextDay
@onready var animation_player := $DayChange/AnimationPlayer

@warning_ignore("integer_division")
const day_limit : float = Persistence.friday_limit/4
const quarter_day : float = day_limit/4

var days : Array[String] = ['Dilluns', 'Dimarts', 'Dimecres', 'Dijous', 'Divendres', 'Dissabte', 'Diumenge']
var quarters : Array[String] = ['Matinada', 'Matí', 'Tarda', 'Nit']
var quarter_day_count : int = 0

func _process(_delta):
    var quarter_reminder = fmod(Persistence.elapsed_time, day_limit)/day_limit
    friday_progress_bar.value = quarter_reminder * friday_progress_bar.max_value
    var current_quarter_day : int = floori(Persistence.elapsed_time / quarter_day)
    if current_quarter_day > quarter_day_count:
        quarter_day_count = current_quarter_day
        update_friday()
        if quarter_day_count % 4 == 0:
            popup_day_change()


func update_friday():
    @warning_ignore("integer_division")
    var day_num : int = quarter_day_count / 4
    var quarter_day_num : int = quarter_day_count % 4

    var day : String = days[day_num] if day_num < len(days) else 'Utopia'
    var quarter : String = quarters[quarter_day_num]
    self.text  = '%s %s' % [day, quarter]

func popup_day_change():
    @warning_ignore("integer_division")
    var day_num : int = quarter_day_count / 4
    previous_day.text = days[day_num-1] if day_num - 1 >= 0 else ""
    next_day.text = days[day_num]
    animation_player.play("day_change")
    #animation_player.queue("RESET")

