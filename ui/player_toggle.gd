extends CheckButton
class_name PlayerToggle

@export var person : String

signal player_toggle(toggled_on : bool, player_name : String)

func _ready():
    self.text = person
    self.toggled.connect(_on_toggled)

func _on_toggled(toggled_on):
    player_toggle.emit(toggled_on, person)
