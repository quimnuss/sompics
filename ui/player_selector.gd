extends Container

@onready var player_spawner = $"../../PlayerSpawner"

func _ready():
    for person in Persistence.possible_pics:
        var player_toggle : PlayerToggle = PlayerToggle.new()
        player_toggle.add_to_group('player_toggle')
        player_toggle.add_theme_font_size_override("font_size", 10)
        player_toggle.person = person
        player_toggle.button_pressed = person in Persistence.pics
        player_toggle.player_toggle.connect(_on_player_toggle_player_toggle)
        self.add_child(player_toggle)


func _on_player_toggle_player_toggle(toggled_on, player_name):
    if toggled_on:
        prints("Added",player_name)
        Persistence.pics.append(player_name)
        player_spawner.spawn_one(player_name)
    else:
        Persistence.pics.erase(player_name)
        for pic in get_tree().get_nodes_in_group('pics'):
            if pic.person == player_name:
                player_spawner.despawn(pic)
                break


func _on_respawn_pressed():
    get_tree().reload_current_scene()


func _on_button_toggled(toggled_on):
    get_tree().call_group('player_toggle', 'set_pressed', toggled_on)

