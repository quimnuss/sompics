extends RigidBody2D

func _integrate_forces(state : PhysicsDirectBodyState2D):
    var total_force = Vector2.ZERO
    for i in range(state.get_contact_count()):
        var object = state.get_contact_collider_object(i)
        if object is RigidBody2D or object is CharacterBody2D:
            total_force += state.get_contact_impulse(i)*state.get_contact_local_normal(i)
        if object is Pic:
            print(object.person)
            $Label.set_text("%s %d,%d" % [object.person, total_force.x, total_force.y])
    #if state.get_contact_count() != 0:
        #prints(state.get_contact_count(), total_force)
