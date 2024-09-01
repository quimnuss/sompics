extends Control

@onready var shake_component = $ShakeComponent
@onready var progress_bar = %ProgressBar

func _ready():
    Persistence.money_changed.connect(progress_bar._on_money_changed)
    Persistence.money_changed.connect(shake_component._on_trigger_shake)
    progress_bar._on_money_changed()
