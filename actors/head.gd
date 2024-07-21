extends Sprite2D


const person_dict : Dictionary = {
    'marta': Rect2(431, 434, 121, 167),
    'pol': Rect2(595, 232, 121, 140),
    'david': Rect2(54, 13, 135, 168),
    'juanpe': Rect2(255, 11, 125, 151),
    'joana': Rect2(418, 10, 144, 161),
    'marite': Rect2(581, 16, 135, 156),
    'isra': Rect2(723, 16, 144, 144),
    'daniestanyol': Rect2(59, 229, 123, 137),
    'xavidolz': Rect2(248, 228, 135, 152),
    'benjami': Rect2(422, 219, 148, 151),
    'nuse': Rect2(728, 221, 137, 145),
    'fran': Rect2(48, 437, 149, 145),
    'jordi': Rect2(242, 439, 146, 151),
    'joan': Rect2(584, 440, 132, 144),
    'raul': Rect2(732, 443, 130, 157),
    'lucia': Rect2(67, 638, 126, 140),
    'pere': Rect2(244, 641, 144, 144),
    'bea': Rect2(433, 640, 139, 151),
    'angel': Rect2(597, 646, 119, 134),
    'oriol': Rect2(733, 645, 143, 135),
    'xavierbonet': Rect2(36, 817, 168, 154),
    'daniquilez': Rect2(235, 828, 141, 129),
    'pau': Rect2(421, 826, 139, 131),
    'xaviteres': Rect2(595, 812, 131, 156),
    'nuse2': Rect2(755, 816, 125, 148)
}

func set_person(person_name : String):
    self.region_rect = person_dict[person_name]
