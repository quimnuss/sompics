extends Container


func _on_continue_pressed():
    Persistence.is_friday_counting = false
    self.visible = false


func _on_to_fites_pressed():
    get_tree().change_scene_to_file('res://ui/fita_browser.tscn')
