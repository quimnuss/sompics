extends ProgressBar

@onready var label : Label = $HBoxContainer/Label

var original_color : Color = Color(1, 1, 1, 1)

func _ready():
    _on_money_changed()

func _on_money_changed():
    var is_estalviing : bool = Persistence.money < self.value
    if is_estalviing:
        self.modulate = Color.RED
        var tween = get_tree().create_tween()
        tween.tween_property(self, "modulate", original_color, 1)

    self.value = Persistence.money
    label.set_text("%d €" % self.value)

