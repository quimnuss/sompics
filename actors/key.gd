extends Node2D
class_name Key
var original_owner

func _ready():
    original_owner = self.owner

func use():
    queue_free()

# TODO maybe just setting target or using a joint2d would be nicer
# https://www.reddit.com/r/godot/comments/18w0pox/how_can_a_characterbody2d_pick_up_a_rigidbody2d/
func _on_area_2d_body_entered(body):
    if body is Pic and body != self.get_parent():
        self.call_deferred("reparent",body)


func _on_area_2d_body_exited(body):
    if body == self.get_parent():
        self.call_deferred("reparent",original_owner)
