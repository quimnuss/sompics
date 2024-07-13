extends Camera2D

@export var start_position : Vector2 = Vector2(576, 328)

var average_position : Vector2 = Vector2(576, 328)

func _ready():
    self.global_position = start_position

func _process(delta):
    self.global_position.y = start_position.y
    self.global_position.x = average_position.x

func _on_player_spawner_player_average_position(avg_position : Vector2):
    average_position = avg_position
