extends Node2D

@onready var weight_platform = $AnimatableWeightPlatform

func _ready():
    weight_platform.required_pics = max(2, len(Persistence.pics) - ceil(2.0/3.0*len(Persistence.pics)))
    weight_platform.update_label()
