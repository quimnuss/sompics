extends Node2D
@onready var key = $Key
@onready var key_spawn = $KeySpawn

func _ready():
    var num_pics : int = len(Persistence.pics)
    if num_pics >= 4:
        @warning_ignore("integer_division")
        var shift : float = min(floor(num_pics/2) * Pic.ROPELENGTH, 200)
        key.global_position.y += shift
        key_spawn.global_position.y += shift

