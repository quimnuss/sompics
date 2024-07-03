extends RigidBody2D
@onready var head = $Head

@export var person : String = 'marta'

var thrust : Vector2 = Vector2()
var rotation_dir = 0
var engine_thrust = 10

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

