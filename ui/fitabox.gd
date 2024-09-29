extends Control
class_name FitaBox
@onready var check_box : CheckBox = $HBoxContainer/CheckBox
@onready var button : Button = $HBoxContainer/Button
@onready var equip_button : Button = $HBoxContainer/EquipButton

var title : String

signal pressed(fita_name)


func setup(title : String, team : String, is_consumed : bool):
    check_box.set_pressed_no_signal(is_consumed)
    button.text = title
    equip_button.text = team



func _on_button_pressed():
    pressed.emit(title)


func _on_check_box_toggled(toggled_on):
    if toggled_on:
        Persistence.consumed_fites.append(title)
    else:
        var fita_idx : int = Persistence.consumed_fites.find(title)
        if fita_idx != -1:
            Persistence.consumed_fites.erase(fita_idx)
