extends Node2D

@export var jump_velocity : float = -800

func _on_area_2d_body_entered(body):
    if body is Pic:
        body.velocity.y = jump_velocity
    if body is Ripic and body.linear_velocity.y > jump_velocity:
        body.linear_velocity.y = jump_velocity
        #body.apply_central_impulse(Vector2(0,jump_velocity))
        
