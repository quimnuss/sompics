extends CharacterBody2D
class_name Pic
@onready var head : Sprite2D = $Head
@onready var jump_sound : AudioStreamPlayer = $jump_sound
@onready var animation_player : AnimationPlayer = $AnimationPlayer

@export var SPEED :float = 200.0
const JUMP_VELOCITY : float = -400.0
var push_force : float = 100.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var person : String = 'marta'

@export var attached_pics : Array[Pic]

var move_left : String = 'move_left'
var move_right : String = 'move_right'
var jump : String = 'jump'
var down : String = 'down'

var ropes : Array[Line2D]

const ROPELENGTH = 120
var key : Key

var is_on_door : bool = false

var coyote_frames = 7
var coyote = false
var was_on_floor = false
@onready var coyote_timer = $CoyoteTimer
var is_jumping : bool = false
var is_pushing_left : bool = false
var is_pushing_right : bool = false

var previous_position : float

signal pic_exit
signal pic_back

func _ready():
    head.set_person(person)
    self.name = person
    coyote_timer.wait_time = coyote_frames / 60.0
    add_to_group('pics')
    if person == 'pol':
        var player_num = 2
        self.move_left = self.move_left + '_' + str(player_num)
        self.move_right = self.move_right  + '_' + str(player_num)
        self.jump = self.jump  + '_' + str(player_num)
        self.down = self.down  + '_' + str(player_num)

    if not attached_pics.is_empty():
        ropes_attach()


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
    attached_pics.append(pic)
    rope_attach(pic)

func rope_attach(attached_pic : Pic):
    var rope : Line2D = Line2D.new()
    rope.width = 2
    rope.default_color = Color.BROWN
    #rope.show_behind_parent = true
    rope.z_as_relative = true
    rope.z_index = -1
    rope.add_point(self.global_position)
    rope.add_point(attached_pic.global_position)
    add_child(rope)
    ropes.append(rope)

func ropes_attach():
    for attached_pic : Pic in attached_pics:
        rope_attach(attached_pic)

func kill():
    head.set_modulate(Color(0.3,0.3,0.3,1))
    self.set_physics_process(false)
    self.set_process(false)
    animation_player.play('death')

func constrain_velocity(attached_pic : Pic):
    var attached_direction : Vector2 = (attached_pic.global_position - self.global_position)
    var lambda = self.velocity.dot(attached_direction.normalized())
    var constrained_velocity = Vector2(0,0)
    if lambda < 10: # moving away + 10 px margin
        constrained_velocity = self.velocity - self.velocity.project(attached_direction.normalized()) + 3*attached_direction.length()*attached_direction.normalized()*Vector2(3,1)
    else:
        constrained_velocity = 5*attached_direction.length()*attached_direction.normalized()

    return constrained_velocity

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

func resolve_pushing(direction : float):

    # evaluate -- not reliable
    #is_pushing_left = false
    #is_pushing_right = false
    #if is_on_wall():
        #if direction < 0 and get_wall_normal() == Vector2(1,0):
            #is_pushing_left = true
        #elif direction > 0 and get_wall_normal() == Vector2(-1,0):
            #is_pushing_right = true

    var dx = global_position.x - previous_position
    previous_position = global_position.x

    is_pushing_left = direction < 0 and dx == 0
    is_pushing_right = direction > 0 and dx == 0

    # consequences
    var left_push = $Area2D/CollisionShape2D as CollisionShape2D
    left_push.disabled = true
    var push_sprite : Sprite2D = $Area2D/Sprite2D as Sprite2D
    push_sprite.visible = false
    if is_pushing_left:
            left_push.disabled = false
            push_sprite.visible = true



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

    var direction : float = Input.get_axis(self.move_left, self.move_right)
    if direction:
        velocity.x = direction * SPEED
    else:
        velocity.x = move_toward(velocity.x, 0, SPEED)

    # TODO handle attached to two players (currently doesnt sum contraints)
    for attached_pic : Pic in attached_pics:
        if attached_pic and is_instance_valid(attached_pic) and self.global_position.distance_to(attached_pic.global_position) > ROPELENGTH:
            velocity = constrain_velocity(attached_pic)

    if len(ropes):
        for i in range(len(attached_pics)):
            var attached_pic : Pic = attached_pics[i] if i < len(attached_pics) else null
            var rope : Line2D = ropes[i] if i < len(ropes) else null
            if attached_pic and is_instance_valid(attached_pic):
                rope.set_point_position(0, Vector2(0,0))
                rope.set_point_position(1, attached_pic.global_position - self.global_position)
                rope.visible = true
            else:
                rope.visible = false

    move_and_slide()

    resolve_pushing(direction)

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
