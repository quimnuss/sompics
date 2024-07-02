extends MarginContainer

var num_grids = 1
var current_grid = 1
var grid_width = 710

@onready var gridbox = $VBoxContainer/HBoxContainer/ClipControl/GridBox

const level_dir : String = 'res://scenes/'

func _ready():
    num_grids = gridbox.get_child_count()
    for grid in gridbox.get_children():
        for box : LevelBox in grid.get_children():
            var num = box.get_index() + 1 + 18 * grid.get_index()
            box.level_num = num
            box.locked = not Persistence.levels[num-1] if num-1 < len(Persistence.levels) else true
            box.level_selected.connect(travel)

func travel(level_num : int):
    prints('Traveling to level ', level_num)
    get_tree().change_scene_to_file(level_dir + 'level_' + str(level_num) + '.tscn')

func _on_back_button_pressed():
    if current_grid > 1:
        current_grid -= 1
        var tween = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
        tween.tween_property(gridbox, "position:x", gridbox.position.x + grid_width, 0.5)
#		gridbox.position.x += grid_width


func _on_next_button_pressed():
    if current_grid < num_grids:
        current_grid += 1
        var tween = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
        tween.tween_property(gridbox, "position:x", gridbox.position.x - grid_width, 0.5)
#		gridbox.position.x -= grid_width
