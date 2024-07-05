extends CharacterBody2D
class_name Pic
@onready var head : Sprite2D = $Head

@export var SPEED = 200.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var person : String = 'marta'

@export var attached_pic : Pic

var move_left : String = 'move_left'
var move_right : String = 'move_right'
var jump : String = 'jump'
var down : String = 'down'

var rope : Line2D

const ROPELENGTH = 120

func _ready():
    head.set_person(person)
    add_to_group('pics')
    if person == 'pol':
        self.SPEED = 200
        var player_num = 2
        self.move_left = self.move_left + '_' + str(player_num)
        self.move_right = self.move_right  + '_' + str(player_num)
        self.jump = self.jump  + '_' + str(player_num)
        self.down = self.down  + '_' + str(player_num)

    if attached_pic:
        rope = Line2D.new()
        rope.width = 2
        rope.default_color = Color.BROWN
        #rope.show_behind_parent = true
        rope.z_as_relative = true
        rope.z_index = -1
        rope.add_point(self.global_position)
        rope.add_point(self.attached_pic.global_position)
        add_child(rope)

var door_exit : Vector2

func enter_door():
    #self.visible = false
    set_physics_process(false)
    door_exit = global_position
    global_position = Vector2.ZERO
    #queue_free()

func exit_door():
    #self.visible = true
    global_position = door_exit
    set_physics_process(true)

var key : Key

func hold(key_ : Key):
    key = key_

func drop():
    if key:
        key.drop()


func attach(pic : Pic):
    var friend_path = pic.get_path()
    #rope.node_b = friend_path

func constrain_velocity(delta, just_jumped):
    var attached_direction : Vector2 = (attached_pic.global_position - self.global_position)
    var lambda = self.velocity.dot(attached_direction.normalized())
    if lambda < 10: # moving away + 10 px margin
        self.velocity = self.velocity - self.velocity.project(attached_direction.normalized()) + 3*attached_direction.length()*attached_direction.normalized()*Vector2(3,1)
    else:
        self.velocity = 5*attached_direction.length()*attached_direction.normalized()

    # not working as intended
    #if just_jumped and not is_on_floor():
        #velocity.y = JUMP_VELOCITY*0.5

var is_on_door : bool = false

func _input(event):
    if event.is_action_pressed(self.jump) and is_on_door:
        enter_door()
    elif event.is_action_pressed(self.down) and is_on_door:
        exit_door()

func _physics_process(delta):

    var attached_velocity = Vector2(0,0)

    # Add the gravity.
    if not is_on_floor():
        velocity.y += gravity * delta
    var just_jumped : bool = Input.is_action_just_pressed(self.jump)
    if just_jumped and is_on_floor():
        velocity.y = JUMP_VELOCITY

    var direction = Input.get_axis(self.move_left, self.move_right)
    if direction:
        velocity.x = direction * SPEED
    else:
        velocity.x = move_toward(velocity.x, 0, SPEED)

    if attached_pic and is_instance_valid(attached_pic) and self.global_position.distance_to(attached_pic.global_position) > ROPELENGTH:
        constrain_velocity(delta, just_jumped)

    if rope and attached_pic and is_instance_valid(attached_pic):
        rope.set_point_position(0, Vector2(0,0))
        rope.set_point_position(1, attached_pic.global_position - self.global_position)

    move_and_slide()
