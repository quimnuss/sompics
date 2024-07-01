extends RigidBody2D


@export var SPEED = 200.0
const JUMP_VELOCITY = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


var move_left : String = 'move_left'
var move_right : String = 'move_right'
var jump : String = 'jump'

func _ready():
    pass # Replace with function body.

func _integrate_forces(state):

    state.apply_central_force(Vector2(10, -1000) * state.get_step())
    #var force : Vector2
#
    #if Input.is_action_just_pressed(self.jump):
        #force.y = JUMP_VELOCITY
#
    #var direction = Input.get_axis(self.move_left, self.move_right)
    #if direction:
        #force.x = direction * SPEED
    #else:
        #force.x = move_toward(force.x, 0, SPEED)
#
    #apply_central_force(force)
