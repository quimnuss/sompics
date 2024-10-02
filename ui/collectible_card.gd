extends MarginContainer
class_name CollectibleCard

@export var collectible_data : CollectibleData

@onready var title_text = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/TitleText
@onready var equip_text = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer3/EquipText
@onready var time_text = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/TimeText
@onready var impacte_text = $MarginContainer/VBoxContainer/ImpacteText
@onready var how_text = $MarginContainer/VBoxContainer/HowText
@onready var why_text = $MarginContainer/VBoxContainer/WhyText
@onready var fita_vista = $MarginContainer/VBoxContainer/HBoxContainer/FitaVista

var image_position : Array[String] = ['all','Dades', 'ERP', 'Suport', 'Webapps']

@export var debug_image_region : Rect2

func _ready():
    add_to_group('collectiblecard')
    refresh_collectible()

func refresh_collectible():
    if not collectible_data or not is_instance_valid(collectible_data):
        push_error('collectible_data is not set')
        return

    title_text.text = collectible_data.title
    equip_text.text = collectible_data.team
    time_text.text = collectible_data.time
    impacte_text.text = collectible_data.impacte
    how_text.text = collectible_data.enabler
    why_text.text = collectible_data.added_value
    var is_consumed : bool = collectible_data.title in Persistence.consumed_fites
    fita_vista.set_pressed(is_consumed)
    set_image(collectible_data.team)



func set_data(new_collectible_data : CollectibleData):
    collectible_data = new_collectible_data


func set_image(team : String):
    match team:
        'Webapps':
            $MarginContainer/VBoxContainer/HBoxContainer/FitaImageWebapps.visible = true
        'Dades':
            $MarginContainer/VBoxContainer/HBoxContainer/FitaImageDades.visible = true
        'ERP':
            $MarginContainer/VBoxContainer/HBoxContainer/FitaImageERP.visible = true
        'Suport':
            $MarginContainer/VBoxContainer/HBoxContainer/FitaImageSuport.visible = true
        _:
            $MarginContainer/VBoxContainer/HBoxContainer/FitaImageAll.visible = true



func _on_fita_vista_toggled(toggled_on):
    if toggled_on:
        Persistence.consumed_fites.append(collectible_data.title)
    else:
        var fita_idx : int = Persistence.consumed_fites.find(collectible_data.title)
        if fita_idx != -1:
            Persistence.consumed_fites.erase(fita_idx)
