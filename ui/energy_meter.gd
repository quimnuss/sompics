extends ProgressBar

@onready var point_light_2d = $AnimatedSprite2D/PointLight2D

var energy_delta : float = 10

var is_powered : bool = false

signal power_up


func _ready():
    energy_delta = self.max_value/len(Persistence.pics)
    self.value = 0


func _on_point_light_2d_energy_lit(is_lit):
    if not is_powered:
        if is_lit:
            self.value += energy_delta
        else:
            self.value -= energy_delta

        if self.value >= self.max_value:
            is_powered = true
            power_up.emit()

