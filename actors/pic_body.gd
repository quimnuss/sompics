extends Sprite2D

var person : String

func _ready():
    person = get_parent().person
    prints('child body person', person)
    self.texture = load('res://assets/it/%s.png' % person)
