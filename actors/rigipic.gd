extends RigidBody2D
class_name Ripic
@onready var floor_detector = $FloorDetector

@export var person : String = 'marta'

@export var SPEED = 300.0
const JUMP_VELOCITY = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var move_left : String = 'move_left'
var move_right : String = 'move_right'
var jump : String = 'jump'
var down : String = 'down'

func _ready():
    if person == 'pol':
        var player_num = 2
        self.move_left = self.move_left + '_' + str(player_num)
        self.move_right = self.move_right  + '_' + str(player_num)
        self.jump = self.jump  + '_' + str(player_num)
        self.down = self.down  + '_' + str(player_num)


func _integrate_forces(state):
    
    $Label.set_text("%5.01f %5.01f" % [self.linear_velocity.x, self.linear_velocity.y])
    
    # TODO allow jumping only on floor (check with spring)
    # jump length control (press_release)
    if Input.is_action_just_pressed(jump) and floor_detector.is_colliding():
        state.apply_central_impulse(Vector2(0, -500))

    var rotation_direction = Vector2.ZERO
    if Input.is_action_pressed(move_right):
        rotation_direction += Vector2.RIGHT
    elif linear_velocity.x > 0:
        state.apply_force(10 * Vector2(-linear_velocity.x,0))
        
    if Input.is_action_pressed(move_left):
        rotation_direction += Vector2.LEFT
    elif linear_velocity.x < 0:
        state.apply_force(10 * Vector2(-linear_velocity.x,0))

    # speed hard limit - softly imposed
    #if linear_velocity.length() > speed:
        #state.apply_force(-linear_velocity.normalized()*speed)

    # space horizontal friction
    if abs(linear_velocity.x) < SPEED:
        state.apply_force(rotation_direction * 5 * SPEED)
        #state.apply_central_impulse(rotation_direction * speed/50)
