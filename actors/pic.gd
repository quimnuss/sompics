extends CharacterBody2D
class_name Pic
@onready var head : Sprite2D = $Head
@onready var jump_sound = $jump_sound

@export var SPEED = 200.0
const JUMP_VELOCITY = -400.0
var push_force = 100.0

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
var key : Key

var is_on_door : bool = false

var coyote_frames = 6
var coyote = false
var was_on_floor = false
@onready var coyote_timer = $CoyoteTimer
var is_jumping : bool = false
var is_pushing_left : bool = false
var is_pushing_right : bool = false

signal pic_exit
signal pic_back

func _ready():
    head.set_person(person)
    self.name = person
    coyote_timer.wait_time = coyote_frames / 60.0
    add_to_group('pics')
    if person == 'pol':
        self.SPEED = 200
        var player_num = 2
        self.move_left = self.move_left + '_' + str(player_num)
        self.move_right = self.move_right  + '_' + str(player_num)
        self.jump = self.jump  + '_' + str(player_num)
        self.down = self.down  + '_' + str(player_num)

    if attached_pic:
        rope_attach()


func enter_door():
    self.set_physics_process(false)
    get_node("CollisionShape2D").disabled = true
    self.is_out = true
    head.set_modulate(Color(1,1,1,0.25))
    pic_exit.emit()

var is_out : bool = false

func exit_door():
    self.set_physics_process(true)
    get_node("CollisionShape2D").disabled = false
    head.set_modulate(Color(1,1,1,1))
    self.is_out = false
    pic_back.emit()

func _process(_delta):
    if is_on_door and not self.is_out and Input.is_action_just_pressed(jump):
            enter_door()
    elif is_out and Input.is_action_just_pressed(jump):
            exit_door()

func hold(key_ : Key):
    key = key_

func drop():
    if key and is_instance_valid(key):
        key.drop()

func attach(pic : Pic):
    attached_pic = pic
    rope_attach()

func rope_attach():
    rope = Line2D.new()
    rope.width = 2
    rope.default_color = Color.BROWN
    #rope.show_behind_parent = true
    rope.z_as_relative = true
    rope.z_index = -1
    rope.add_point(self.global_position)
    rope.add_point(self.attached_pic.global_position)
    add_child(rope)

func kill():
    head.set_modulate(Color(0.3,0.3,0.3,1))
    self.set_physics_process(false)
    self.set_process(false)

func constrain_velocity():
    var attached_direction : Vector2 = (attached_pic.global_position - self.global_position)
    var lambda = self.velocity.dot(attached_direction.normalized())
    if lambda < 10: # moving away + 10 px margin
        self.velocity = self.velocity - self.velocity.project(attached_direction.normalized()) + 3*attached_direction.length()*attached_direction.normalized()*Vector2(3,1)
    else:
        self.velocity = 5*attached_direction.length()*attached_direction.normalized()

    # not working as intended
    #if just_jumped and not is_on_floor():
        #velocity.y = JUMP_VELOCITY*0.5

func external_input(player : String, action : String, is_pressed : bool = true):

    if player != self.person:
        return
    print("external " + action)
    if is_pressed:
        Input.action_press(action)
    else:
        # TODO also needs the release
        #await get_tree().create_timer(1).timeout
        Input.action_release(action)

func _physics_process(delta):

    # TODO asymetrical jump (better jump)
    var grav_factor = 1
    #if velocity.y > 0:
        #grav_factor = 3
    if not is_on_floor():
        velocity.y += grav_factor*gravity * delta

    var just_jumped : bool = Input.is_action_just_pressed(self.jump)
    if just_jumped and (is_on_floor() or coyote):
        velocity.y = JUMP_VELOCITY
        is_jumping = true
        jump_sound.play()

    var direction = Input.get_axis(self.move_left, self.move_right)
    if direction:
        velocity.x = direction * SPEED
    else:
        velocity.x = move_toward(velocity.x, 0, SPEED)

    # TODO handle attached to two players
    if attached_pic and is_instance_valid(attached_pic) and self.global_position.distance_to(attached_pic.global_position) > ROPELENGTH:
        constrain_velocity()

    if rope:
        if attached_pic and is_instance_valid(attached_pic):
            rope.set_point_position(0, Vector2(0,0))
            rope.set_point_position(1, attached_pic.global_position - self.global_position)
            rope.visible = true
        else:
            rope.visible = false

    move_and_slide()

    is_pushing_left = false
    is_pushing_right = false
    if is_on_wall():
        if direction < 0 and get_wall_normal() == Vector2(1,0):
            is_pushing_left = true
        elif direction > 0 and get_wall_normal() == Vector2(-1,0):
            is_pushing_right = true

    # box interaction
    for i in get_slide_collision_count():
        var c = get_slide_collision(i)
        if c.get_collider() is RigidBody2D:
            c.get_collider().apply_central_impulse(-c.get_normal() * push_force)

    if not is_on_floor() and was_on_floor and not is_jumping:
        coyote = true
        coyote_timer.start()

    if is_on_floor() and is_jumping:
        is_jumping = false

    if velocity.x > 0:
        #$AnimatedSprite2d.flip_h = false
        head.flip_h = false
    if velocity.x < 0:
        #$AnimatedSprite2d.flip_h = true
        head.flip_h = true

    was_on_floor = is_on_floor()


func _on_coyote_timer_timeout():
    coyote = false
