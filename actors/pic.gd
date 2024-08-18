extends CharacterBody2D
class_name Pic
@onready var head : Sprite2D = $Head
@onready var jump_sound : AudioStreamPlayer = $jump_sound
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var area_2d : Area2D = $Area2D

@export var SPEED :float = 200.0
const JUMP_VELOCITY : float = -400.0
var push_force : float = 100.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var person : String = 'marta'

@export var attached_pics : Array[Pic]

var actions : Array[String] = ['jump', 'move_left', 'move_right', 'down']

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

@export var is_flying : bool = false

var previous_position : float

signal pic_exit
signal pic_back

func _ready():
    head.set_person(person)
    self.name = person
    coyote_timer.wait_time = coyote_frames / 60.0
    add_to_group('pics')

    self.move_left = self.move_left + '-' + person
    self.move_right = self.move_right  + '-' + person
    self.jump = self.jump  + '-' + person
    self.down = self.down  + '-' + person

    for action : String in actions:
        if not InputMap.has_action(action + '-' + person):
            InputMap.add_action(action + '-' + person)

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
    var is_controlled : bool = Persistence.pics[Persistence.active_pic] == person
    var just_jumped : bool = Input.is_action_just_pressed(jump) or Input.is_action_just_pressed('jump-q') and is_controlled

    if is_on_door and not self.is_out and just_jumped:
        enter_door()
    elif is_out and just_jumped:
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


func external_input(player : String, action : String, is_pressed : bool = true):

    if player != self.person:
        return
    var input_action : String = action + '-' + player
    prints("external input ", input_action)
    if is_pressed:
        Input.action_press(input_action)
    else:
        Input.action_release(input_action)

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

func constrain_velocity(attached_pic : Pic, delta : float):
    var attached_direction : Vector2 = (attached_pic.global_position - self.global_position)

    #var gravity_pull : Vector2 = Vector2(0,0)
    #var mass : float = 10
    ## TODO gravity force should push the pic towards the wall
    #if not is_on_floor():
        ## the force
        #gravity_pull = mass*gravity*Vector2(0,1)
        ##gravity_pull = (gravity*Vector2(0,1)).dot(-attached_direction.normalized())
    #var lambda = -self.velocity.cross(attached_direction.normalized())
    #var lambda_dot = self.velocity.dot(attached_direction.normalized())

    var dx = attached_direction.length() - ROPELENGTH
    var K = 5
    var constrained_velocity = 10*K*dx*attached_direction.normalized()*delta

    return constrained_velocity

func _physics_process(delta):

    var is_controlled : bool = Persistence.pics[Persistence.active_pic] == person

    var just_jumped : bool = Input.is_action_just_pressed(jump) or Input.is_action_just_pressed('jump-q') and is_controlled
    var flying_direction : Vector2 = Input.get_vector(move_left, move_right, jump, down) if not is_controlled else Input.get_vector('move_left-q', 'move_right-q', 'jump-q', 'down-q')
    var horizontal_direction : float = Input.get_axis(move_left, move_right) if not is_controlled else Input.get_axis('move_left-q', 'move_right-q')

    if is_flying:
        var direction : Vector2 = flying_direction
        velocity = direction * SPEED
        move_and_slide()
        return

    # TODO asymetrical jump (better jump)
    var grav_factor = 1
    if velocity.y > 0:
        grav_factor = 3

    if not is_on_floor():
        velocity.y += grav_factor * gravity * delta

    var direction : float = 0
    if just_jumped and (is_on_floor() or coyote):
        velocity.y = JUMP_VELOCITY
        is_jumping = true
        jump_sound.play()

    self.set_collision_layer_value(6, is_on_floor() or not is_jumping)

    direction = horizontal_direction
    if direction:
        velocity.x = direction * SPEED

    if attached_pics.is_empty():
        if not direction:
            velocity.x = 0 # move_toward(velocity.x, 0, SPEED)
    else:
        var rope_velocity : Vector2 = Vector2(0,0)

        for attached_pic : Pic in attached_pics:
            if attached_pic and is_instance_valid(attached_pic) and self.global_position.distance_to(attached_pic.global_position) > ROPELENGTH-10:
                rope_velocity += constrain_velocity(attached_pic,delta)

        velocity += rope_velocity

        if not direction and abs(rope_velocity.x) < 0.01:
            velocity.x = 0
        elif not direction and is_on_floor(): # friction
            velocity.x = move_toward(velocity.x, 0, 5*SPEED*delta)

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

    $Label.set_text("%.2f %.2f" % [velocity.x, velocity.y])

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
