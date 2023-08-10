if(shield && shield_timer <= max_timer){
	shield_timer += 1
	x = owner.x
	y = owner.y
} else if(shield_timer > max_timer){
	owner.shield = false
	instance_destroy()
}