extends RigidBody2D


@export var SPEED = 200.0
const JUMP_VELOCITY = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


var move_left : String = 'move_left'
var move_right : String = 'move_right'
var jump : String = 'jump'

var speed = Vector2(5000,0)

func _ready():
    pass # Replace with function body.

var thrust = Vector2(0, -2050)
var torque = 20000

func _integrate_forces(state):
    if Input.is_action_pressed(jump):
        print('jump')
        state.apply_force(thrust.rotated(rotation))
    else:
        state.apply_force(Vector2())
    var rotation_direction = 0
    if Input.is_action_pressed(move_right):
        rotation_direction += 1
    if Input.is_action_pressed(move_left):
        rotation_direction -= 1
    state.apply_force(rotation_direction * speed)
