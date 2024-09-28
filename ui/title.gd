extends Label

@export var level_name : int

func _ready():
    var fullpath : String = get_tree().current_scene.scene_file_path
    var level : String = fullpath.right(7).left(2)
    level_name = int(level)
    if level_name != 18:
        self.text = 'User Story ' + str(level_name)
    else:
        self.text = "Escapeu!"
