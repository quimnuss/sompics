@tool
extends BoxContainer
class_name SelectionCarousel

signal option_changed(new_value)
signal update_selected(new_value)
@export var carousel_options:PackedStringArray:
  get:
    return carousel_options
  set(value):
    carousel_options = value
    option_changed.emit(value)

@export var selected:int = -1:
  get:
    return selected
  set(value):
    if(value <= carousel_options.size()-1):
      selected = value
    elif(value > carousel_options.size()-1):
      selected = carousel_options.size()-1
    else:
      selected = -1
    update_selected.emit(value)

var option:Label
var b1:Button
var b2:Button

func _init():
  self.set_custom_minimum_size(Vector2(120, 10))
  self.option_changed.connect(_options_changed)
  self.update_selected.connect(_update_selection)
  self.size_flags_horizontal = Control.SIZE_EXPAND_FILL

  b1 = Button.new()
  b1.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
  b1.set_custom_minimum_size(Vector2(10,10))
  b1.text = "<"
  b1.pressed.connect(_decrement)

  b2 = Button.new()
  b2.size_flags_horizontal = Control.SIZE_SHRINK_END
  b2.set_custom_minimum_size(Vector2(10,10))
  b2.text = ">"
  b2.pressed.connect(_increment)

  option = Label.new()
  option.size_flags_horizontal = Control.SIZE_EXPAND_FILL
  option.set_custom_minimum_size(Vector2(50,10))
  option.text = "-Carousel-"
  option.autowrap_mode = TextServer.AUTOWRAP_OFF
  option.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
  option.text_overrun_behavior = TextServer.OVERRUN_TRIM_ELLIPSIS
  option.vertical_alignment = VERTICAL_ALIGNMENT_CENTER

  self.add_child(b1)
  self.add_child(option)
  self.add_child(b2)

func _options_changed(value:PackedStringArray)->void:
  if(value.size() > 0):
    if(selected == -1):
        selected = 0
    elif(selected > carousel_options.size()-1):
        selected = carousel_options.size()-1
        option.text = value[selected]
  else:
    selected = -1
    option.text = "-Carousel-"

func _update_selection(value:int)->void:
  if(carousel_options.size()>0):
    if(value<0):
      selected = 0
    option.text = carousel_options[selected]

func _decrement()->void:
  self.set(&"selected", selected-1)

func _increment()->void:
  self.set(&"selected", selected+1)
