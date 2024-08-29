extends RigidBody2D


func _integrate_forces(state):
	var count = state.get_contact_count()
	for i in count:
		print("Contact #", i, ", impulse: ", state.get_contact_impulse(i))
