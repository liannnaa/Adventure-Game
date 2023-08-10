x_vel *= 0.9
y_vel += grav

// respawn
if(respawn_timer > 0){
	respawn_timer -= 1
	if(respawn_timer <= 0){
		x = round(random_range(room_width * 0.25, room_width * 0.75))
		y = -16
		x_vel = (x-room_width * 0.5) * random_range(0.1, 0.2)
		y_vel = 0
		r_x = 0
		r_y = 0
		knockout = false
		audio_play_sound(snd_revive, 1, false)
	}
}

r_x += x_vel
r_y += y_vel

var to_move_x = round(r_x)
var to_move_y = round(r_y)

r_x -= to_move_x
r_y -= to_move_y

// wall bounce
var dist_to_r_wall = room_width - x - 8
var dist_to_l_wall = x - 8

var dir = sign(to_move_y)

if(to_move_x >= dist_to_r_wall){
	x = room_width - 9
	x_vel = abs(x_vel) * -1
	r_x = 0
	audio_play_sound(snd_wall, 1, false)
} else if(to_move_x < -dist_to_l_wall){
	x = 9
	x_vel = abs(x_vel)
	r_x = 0
	audio_play_sound(snd_wall, 1, false)
} else {
	x += to_move_x
}

// collisions
while(to_move_y != 0){
	var colliding = false
	var collide_with = noone
	
	if(dir >= 0){
		collide_with = instance_place(x, y + dir, obj_player)
		if(collide_with != noone && collide_with != self){
			if(place_meeting(x, y, collide_with) == false){
				colliding = true
				
				if(shield || (keyboard_check(down_key) && keyboard_check(collide_with.up_key))){
					collide_with.y_vel = max(0, collide_with.y_vel + light_knockback)
					part_particles_create(parts, x, y+10, block, 5)	
					audio_play_sound(snd_block, 1, false)
				}
		        else if (keyboard_check(down_key) && !keyboard_check(collide_with.up_key)) {
		            collide_with.y_vel = max(0, collide_with.y_vel + heavy_knockback)
		            collide_with.points -= 2
					
					part_particles_create(parts, x, y+10, spark, 10)
					
					audio_play_sound(snd_stomp, 1, false)
					collide_with.image_index = 6
					
		        } else {
					part_particles_create(parts, x, y+10, block, 10)	
		            collide_with.y_vel = max(0, collide_with.y_vel + 2)
					collide_with.points -= 1
					audio_play_sound(snd_stomp, 1, false)
				}
				
				if(left){
					image_index = 3
				} else {
					image_index = 0
				}
			}
		} else {
			collide_with = instance_place(x, y + dir, obj_cloud)
			if(collide_with != noone){
				if(place_meeting(x, y, collide_with) == false){
					colliding = true
					instance_destroy(collide_with)
					audio_play_sound(snd_jump, 1, false)
					part_particles_create(parts, x, y, poof, 10)
					if(left){
						image_index = 3
					} else {
						image_index = 0
					}
				}
			}
			
			collide_with = instance_place(x, y, obj_item)
			if(collide_with != noone){
				if(collide_with.type == "shield"){
					collide_with.shield = true
					collide_with.owner = self
					collide_with.type = "used"
					collide_with.image_xscale = 1
					collide_with.image_yscale = 1
					collide_with.x = x
					collide_with.y = y
					if(!shield){
						shield = true
						audio_play_sound(snd_collect, 1, false)
					}
				} else if(collide_with.type == "heart"){
					points += 1
					instance_destroy(collide_with)
					audio_play_sound(snd_collect, 1, false)
				}
			}
			
			collide_with = instance_place(x, y, obj_lightning)
			if(collide_with != noone){
				points -= 1
				instance_destroy(collide_with)
				audio_play_sound(snd_crack, 1, false)
				image_index = 6
				part_particles_create(parts, x, y, spark, 20)
			}
			
		}
	}
	
	if(!colliding){
		y += dir
		if(dir > 0){
			if(left){
				image_index = 5
			} else {
				image_index = 2
			}
		}
		to_move_y -= dir
	} else {
		y = y + dir
		if(left){
			image_index = 4
		} else {
			image_index = 1
		}
		y_vel = bounce_vel
		r_y = 0
		break;
	}
}

// reach bottom
if(y > room_height && respawn_timer == 0){
	knockout = true
	respawn_timer = respawn_time_reset
	
	if(!shield){
		points -= 1
		part_particles_create(parts, x, y-10, spark, 10)
	
		audio_play_sound(snd_die, 1, false)
	}
}

// player movement
if(keyboard_check(left_key)){
	x_vel -= accel
	left = true
} else if(keyboard_check(right_key)){
	x_vel += accel
	left = false
}

if(points <= 0){
	global.loser = player
	audio_play_sound(snd_jump, 1, false)
	room_goto(rm_end)
}
