extends CharacterBody2D
class_name Pic
@onready var head : Sprite2D = $Head

@export var SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var person : String = 'marta'

const person_dict : Dictionary = {
    'marta': Rect2(431, 434, 121, 167),
    'pol': Rect2(595, 232, 121, 140),
    'joana': Rect2(418, 10, 144, 161),
    'david': Rect2(54, 13, 135, 168),
    'juanpe': Rect2(255, 11, 125, 151),
}

func _ready():
    head.region_rect = person_dict[person]

func _physics_process(delta):
    # Add the gravity.
    if not is_on_floor():
        velocity.y += gravity * delta

    # Handle jump.
    if Input.is_action_just_pressed("jump") and is_on_floor():
        velocity.y = JUMP_VELOCITY

    # Get the input direction and handle the movement/deceleration.
    # As good practice, you should replace UI actions with custom gameplay actions.
    var direction = Input.get_axis("move_left", "move_right")
    if direction:
        velocity.x = direction * SPEED
    else:
        velocity.x = move_toward(velocity.x, 0, SPEED)

    move_and_slide()
