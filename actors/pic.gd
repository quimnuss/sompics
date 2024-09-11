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

var actions : Array[String] = ['jump', 'move_left', 'move_right', 'move_down']

var move_left : String = 'move_left'
var move_right : String = 'move_right'
var jump : String = 'jump'
var move_down : String = 'move_down'

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
var is_out : bool = false

@export var is_flying : bool = false

var is_possessed : bool = true

var previous_position : float

var debug_velocity : Vector2

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
    self.move_down = self.move_down  + '-' + person

    for action : String in actions:
        if not InputMap.has_action(action + '-' + person):
            InputMap.add_action(action + '-' + person)

    if not attached_pics.is_empty():
        ropes_attach()

    if person in Persistence.ce_members:
        ghost()


func enter_door():
    self.set_physics_process(false)
    get_node("CollisionShape2D").disabled = true
    self.is_out = true
    head.set_modulate(Color(1,1,1,0.25))
    pic_exit.emit()


func exit_door():
    self.set_physics_process(true)
    get_node("CollisionShape2D").disabled = false
    head.set_modulate(Color(1,1,1,1))
    self.is_out = false
    pic_back.emit()


func get_is_controlled() -> bool:
    return Persistence.pics[Persistence.active_pic] == person and is_possessed


func _process(_delta):
    var is_controlled : bool = get_is_controlled()
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

func unghost():
    $Head.modulate.a = 1


func ghost():
    $Head.modulate.a = 0.6


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
    if action == 'move_up':
        input_action = 'jump-' + player
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
    var left_push : CollisionShape2D = $PushingArea2D/CollisionShape2D as CollisionShape2D
    left_push.disabled = true
    var push_sprite : Sprite2D = $PushingArea2D/Sprite2D as Sprite2D
    push_sprite.visible = false
    if is_pushing_left or is_pushing_right:
        left_push.disabled = false
        push_sprite.visible = true


func draw_ropes():
    for i in range(len(attached_pics)):
        var attached_pic : Pic = attached_pics[i] if i < len(attached_pics) else null
        var rope : Line2D = ropes[i] if i < len(ropes) else null
        if attached_pic and is_instance_valid(attached_pic):
            rope.set_point_position(0, Vector2(0,0))
            rope.set_point_position(1, attached_pic.global_position - self.global_position)
            rope.visible = true
        else:
            rope.visible = false

func _physics_process(delta):

    var is_controlled : bool = get_is_controlled()

    # doesn't work dunno why. Anyway get_is_controlled is enough for external controllers so... whatever
    #if not is_possessed:
        #if not is_on_floor():
            #velocity.y += gravity * delta
            #move_and_slide()
        #return

    var just_jumped : bool = Input.is_action_just_pressed(jump) or Input.is_action_just_pressed('jump-q') and is_controlled
    var flying_direction : Vector2 = Input.get_vector(move_left, move_right, jump, move_down)
    var direction : float = Input.get_axis(move_left, move_right)

    if is_controlled:
        if direction == 0:
            direction = Input.get_axis('move_left-q', 'move_right-q')
        if flying_direction == Vector2.ZERO:
            flying_direction = Input.get_vector('move_left-q', 'move_right-q', 'jump-q', 'move_down-q')

    if is_flying:
        velocity = flying_direction * SPEED
        move_and_slide()
        return

    # attached
    if not attached_pics.is_empty():
        _physics_process_attached(delta, just_jumped, direction)
        return

    var grav_factor = 1
    if velocity.y > 0:
        grav_factor = 3

    if not is_on_floor():
        velocity.y += grav_factor * gravity * delta

    if just_jumped and (is_on_floor() or coyote):
        velocity.y = JUMP_VELOCITY
        is_jumping = true
        jump_sound.play()

    self.set_collision_layer_value(6, is_on_floor() or not is_jumping)

    if direction:
        velocity.x = direction * SPEED

    if attached_pics.is_empty():
        if not direction:
            velocity.x = 0 # move_toward(velocity.x, 0, SPEED)

    move_and_slide()

    debug_velocity = self.velocity

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
    elif velocity.x < 0:
        #$AnimatedSprite2d.flip_h = true
        head.flip_h = true

    was_on_floor = is_on_floor()


func _physics_process_attached(delta : float, just_jumped : bool, direction : float):

    var grav_factor = 1
    # disable when attached because it messes with spring equations
    if velocity.y > 0 and attached_pics.is_empty():
        grav_factor = 3

    if not is_on_floor():
        velocity.y += grav_factor * gravity * delta

    if just_jumped and (is_on_floor() or coyote):
        velocity.y = JUMP_VELOCITY
        is_jumping = true
        jump_sound.play()
    elif just_jumped and is_on_wall():
        velocity.y = JUMP_VELOCITY
        is_jumping = true
        jump_sound.play()

    if direction and (is_on_floor() or is_on_wall() or is_jumping):
        velocity.x = direction * SPEED

    var rope_velocity : Vector2 = Vector2(0,0)
    var K : float = 50
    var cum_dl : Vector2 = Vector2.ZERO
    for attached_pic : Pic in attached_pics:
        if attached_pic and is_instance_valid(attached_pic) and self.global_position.distance_to(attached_pic.global_position) > ROPELENGTH-10:
            var attached_vector : Vector2 = (attached_pic.global_position - self.global_position)
            var attached_direction : Vector2 = attached_vector.normalized()
            var dl = attached_vector.length() - ROPELENGTH
            if dl > 0:
                cum_dl += attached_vector - ROPELENGTH*attached_direction
                var constrained_velocity = K*dl*attached_direction*delta
                rope_velocity += constrained_velocity

    #rope_velocity = rope_velocity.clamp(Vector2.ONE*-50, Vector2.ONE*50)
    velocity += rope_velocity
    if cum_dl.length() > 0: # -- removed because is_jumping is on until floor hits
        const C : float = 1
        var damp : Vector2 = -C*velocity*delta
        velocity += damp
    elif not is_on_floor() and velocity.y > 0 and is_jumping:
        velocity.y += 2 * gravity * delta

    #velocity = velocity.clamp(Vector2.ONE*-600, Vector2.ONE*600)

    if not direction and abs(rope_velocity.x) < 0.01:
        velocity.x = 0
    elif not direction and is_on_floor(): # friction
        velocity.x = move_toward(velocity.x, 0, 5*SPEED*delta)

    if len(ropes):
        draw_ropes()

    move_and_slide()

    debug_velocity = self.velocity

    $Label.set_text("%.2f %.2f" % [velocity.x, velocity.y])

    resolve_pushing(direction)

    if not is_on_floor() and was_on_floor and not is_jumping:
        coyote = true
        coyote_timer.start()

    if (is_on_floor() or is_on_wall()) and is_jumping:
        is_jumping = false

    if velocity.x > 0:
        #$AnimatedSprite2d.flip_h = false
        head.flip_h = false
    if velocity.x < 0:
        #$AnimatedSprite2d.flip_h = true
        head.flip_h = true

    was_on_floor = is_on_floor()


func possess_toggle(new_is_possessed : bool):
    is_possessed = new_is_possessed


func _on_coyote_timer_timeout():
    coyote = false
