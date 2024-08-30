extends Area2D

func _ready():
    self.area_shape_entered.connect(_on_area_shape_entered)


func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
    if area is CallDotFalling:
        area.queue_free()
