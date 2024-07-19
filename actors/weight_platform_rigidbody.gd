extends RigidBody2D

func _integrate_forces(state : PhysicsDirectBodyState2D):
    var total_force = Vector2.ZERO
    for i in range(state.get_contact_count()):
        var object = state.get_contact_collider(i)
        if object is RigidBody2D or object is CharacterBody2D:
            total_force += state.get_contact_impulse(i)
    if state.get_contact_count() != 0:
        prints(state.get_contact_count(), total_force)
