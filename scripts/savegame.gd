extends Resource
class_name SaveGame

@export var fites : Array[String]

func clear():
    fites.clear()

func add_fita(fita : CollectibleData):
    if fita.title not in fites:
        fites.append(fita.title)

func as_dict():
    return {'fites': fites}

func from_dict(data : Dictionary):
    fites = data['fites']
