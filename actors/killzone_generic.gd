extends Area2D

func _ready():
    self.area_shape_entered.connect(_on_area_shape_entered)


func _on_area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
    if area is CallDotFalling:
        area.queue_free()
