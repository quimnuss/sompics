extends Camera2D


func _on_player_spawner_player_average_position(avg_position : Vector2):
    self.global_position = avg_position

