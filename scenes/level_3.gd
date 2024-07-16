extends Node2D

@onready var weight_platform = $Node2D/WeightPlatform

func _ready():
    weight_platform.required_pics = len(Persistence.pics)  

