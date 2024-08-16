extends Node2D

@onready var weight_platform = $Node2D/WeightPlatform

func _ready():
    weight_platform.required_pics = max(2, len(Persistence.pics) - 5)
    weight_platform.update_label()
