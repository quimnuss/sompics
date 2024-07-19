extends Node2D

@onready var weight_platform_rigid = $Node2D/WeightPlatformRigid


func _ready():
    weight_platform_rigid.required_pics = len(Persistence.pics)
