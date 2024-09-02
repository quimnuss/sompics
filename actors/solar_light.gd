extends PointLight2D
class_name EnergyLight

var num_pics : int = 0

signal energy_lit(is_lit : bool)

func _ready():
    add_to_group('lights')

func _on_area_2d_body_entered(body):
    if body is Pic:
        if num_pics <= 2:
            num_pics += 1
            energy_lit.emit(true)


func _on_area_2d_body_exited(body):
    if body is Pic:
        if num_pics <= 2:
            num_pics -= 1
            energy_lit.emit(false)

