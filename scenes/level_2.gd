extends Node2D

@onready var weight_platform = $AnimatableWeightPlatform


func _ready():
    weight_platform.required_pics = len(Persistence.pics)
    weight_platform.update_label()
