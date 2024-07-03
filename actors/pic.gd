extends CharacterBody2D
class_name Pic
@onready var head : Sprite2D = $Head

@export var SPEED = 200.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var person : String = 'marta'



var move_left : String = 'move_left'
var move_right : String = 'move_right'
var jump : String = 'jump'

func _ready():
    head.set_person(person)
    add_to_group('pics')
    if person == 'pol':
        self.SPEED = 200
        var player_num = 2
        self.move_left = self.move_left + '_' + str(player_num)
        self.move_right = self.move_right  + '_' + str(player_num)
        self.jump = self.jump  + '_' + str(player_num)

func enter_door():
    queue_free()

var key : Key

func hold(key_ : Key):
    key = key_

func drop():
    if key:
        key.drop()

func attach(pic : Pic):
    var friend_path = pic.get_path()
    #rope.node_b = friend_path


func _physics_process(delta):

    # Add the gravity.
    if not is_on_floor():
        velocity.y += gravity * delta

    if Input.is_action_just_pressed(self.jump) and is_on_floor():
        velocity.y = JUMP_VELOCITY

    var direction = Input.get_axis(self.move_left, self.move_right)
    if direction:
        velocity.x = direction * SPEED
    else:
        velocity.x = move_toward(velocity.x, 0, SPEED)

    move_and_slide()
