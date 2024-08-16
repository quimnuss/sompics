extends Path2D
class_name WeightPlatform

@onready var label = $FollowPath2D/AnimatableBody2D/Label
@onready var follow_path = $FollowPath2D

var pics_on_platform : int = 0
@export var required_pics : int = 1

var velocity : float = 0

func _ready():
    update_label()

func update_label():
    var missing_pics : int = max(0, required_pics - pics_on_platform)
    label.set_text(str(missing_pics))

func _physics_process(delta):
    var current_progress : float = follow_path.get_progress_ratio()
    if pics_on_platform >= required_pics:
        if current_progress < 1:
            velocity = 0.2
            current_progress = min(1, current_progress + velocity*delta)
            follow_path.set_progress_ratio(current_progress)
    elif current_progress > 0:
        velocity = move_toward(velocity, -0.2, 1*delta)
        current_progress = clamp(current_progress + velocity*delta, 0, 1)
        follow_path.set_progress_ratio(current_progress)
    else:
        velocity = 0

func _on_area_2d_body_entered(body):
    if body is Pic:
        pics_on_platform += 1
        update_label()

func _on_area_2d_body_exited(body):
    if body is Pic:
        pics_on_platform -= 1
        update_label()
