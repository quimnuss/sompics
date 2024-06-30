extends Marker2D

var pic_scene = preload('res://actors/pic.tscn')

func _ready():
    var pics_array = Persistence.pics
    for pic_name in pics_array:
        #TODO prevent spawning inside the collider OR posess characters manually placed on level OR activate collisions with other players when not colliding
        await get_tree().create_timer(1.0).timeout
        var pic : Pic = pic_scene.instantiate()
        pic.person = pic_name
        self.add_child(pic)


