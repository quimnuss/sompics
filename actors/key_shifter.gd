extends Node2D

const SHIFT_DISTANCE_PER_PIC : float = 60

func _ready():
    var shift_distance = SHIFT_DISTANCE_PER_PIC*floor(len(Persistence.pics)/2 - 1)
    self.global_position.y += shift_distance

