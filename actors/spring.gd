extends Node2D

const JUMP_VELOCITY : float = -800

func _on_area_2d_body_entered(body):
    if body is Pic:
        var pic = body as Pic
        body.velocity.y = JUMP_VELOCITY
