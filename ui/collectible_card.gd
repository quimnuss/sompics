extends MarginContainer
class_name CollectibleCard

@export var collectible_data : CollectibleData

@onready var title_text = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/TitleText
@onready var time_text = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/TimeText
@onready var impacte_text = $MarginContainer/VBoxContainer/ImpacteText
@onready var how_text = $MarginContainer/VBoxContainer/HowText
@onready var why_text = $MarginContainer/VBoxContainer/WhyText

func _ready():
    add_to_group('collectiblecard')
    refresh_collectible()

func refresh_collectible():
    if not collectible_data or not is_instance_valid(collectible_data):
        push_error('collectible_data is not set')
        return

    title_text.text = collectible_data.title
    time_text.text = collectible_data.time
    impacte_text.text = collectible_data.impacte
    how_text.text = collectible_data.enabler
    why_text.text = collectible_data.added_value

func set_data(new_collectible_data : CollectibleData):
    collectible_data = new_collectible_data
    
