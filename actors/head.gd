extends Sprite2D


const person_dict : Dictionary = {
    'marta': Rect2(431, 434, 121, 167),
    'pol': Rect2(595, 232, 121, 140),
    'joana': Rect2(418, 10, 144, 161),
    'david': Rect2(54, 13, 135, 168),
    'juanpe': Rect2(255, 11, 125, 151),
}

func set_person(person_name : String):
    self.region_rect = person_dict[person_name]
