extends ProgressBar

@onready var label : Label = $HBoxContainer/Label

func _ready():
    _on_money_changed()

func _on_money_changed():
    self.value = Persistence.money
    label.set_text("%d €" % self.value)
