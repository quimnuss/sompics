extends Node2D
@onready var door : Door = $Door


# Called when the node enters the scene tree for the first time.
func _ready():
    var pics : Array = get_tree().get_nodes_in_group("pics")
    door.num_pics = len(pics)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass
