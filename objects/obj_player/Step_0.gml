// Apply friction to horizontal velocity and gravity to vertical velocity.
x_vel *= 0.9;
y_vel += grav;

if(respawn_timer > 0) {
    respawn_timer -= 1;
    if(respawn_timer <= 0) {
        // Reset position and velocities
        x = round(random_range(room_width * 0.25, room_width * 0.75));
        y = -16;
        x_vel = (x - room_width * 0.5) * random_range(0.1, 0.2);
        y_vel = 0;
        r_x = 0;
        r_y = 0;
        knockout = false;
        audio_play_sound(snd_revive, 1, false);
    }
}

// Update position based on velocity
r_x += x_vel;
r_y += y_vel;

// Calculate integer amount to move
var _to_move_x = round(r_x);
var _to_move_y = round(r_y);

// Update remainder after moving
r_x -= _to_move_x;
r_y -= _to_move_y;

// Wall bounce logic
var _dist_to_r_wall = room_width - x - 8;
var _dist_to_l_wall = x - 8;

if(_to_move_x >= _dist_to_r_wall) {
    x = room_width - 9;
    x_vel = abs(x_vel) * -1;
    r_x = 0;
    audio_play_sound(snd_wall, 1, false);
} else if(_to_move_x < -_dist_to_l_wall) {
    x = 9;
    x_vel = abs(x_vel);
    r_x = 0;
    audio_play_sound(snd_wall, 1, false);
} else {
    x += _to_move_x;
}

// Collision detection and handling
var _dir = sign(_to_move_y);

while(_to_move_y != 0) {
    while(_to_move_y != 0){
		var _colliding = false
		var _collide_with = noone
	
		if(_dir >= 0){
			_collide_with = instance_place(x, y + _dir, obj_player)
			if(_collide_with != noone && _collide_with != self){
				if(place_meeting(x, y, _collide_with) == false){
					_colliding = true
				
					if(shield || (keyboard_check(down_key) && keyboard_check(_collide_with.up_key))){
						_collide_with.y_vel = max(0, _collide_with.y_vel + light_knockback)
						part_particles_create(parts, x, y+10, block, 5)	
						audio_play_sound(snd_block, 1, false)
					}
				    else if (keyboard_check(down_key) && !keyboard_check(_collide_with.up_key)) {
				        _collide_with.y_vel = max(0, _collide_with.y_vel + heavy_knockback)
				        _collide_with.points -= 2
					
						part_particles_create(parts, x, y+10, spark, 10)
					
						audio_play_sound(snd_stomp, 1, false)
						_collide_with.image_index = 6
					
				    } else {
						part_particles_create(parts, x, y+10, block, 10)	
				        _collide_with.y_vel = max(0, _collide_with.y_vel + 2)
						_collide_with.points -= 1
						audio_play_sound(snd_stomp, 1, false)
					}
				
					if(left){
						image_index = 3
					} else {
						image_index = 0
					}
				}
			} else {
				_collide_with = instance_place(x, y + _dir, obj_cloud)
				if(_collide_with != noone){
					if(place_meeting(x, y, _collide_with) == false){
						_colliding = true
						instance_destroy(_collide_with)
						audio_play_sound(snd_jump, 1, false)
						part_particles_create(parts, x, y, poof, 10)
						if(left){
							image_index = 3
						} else {
							image_index = 0
						}
					}
				}
			
				_collide_with = instance_place(x, y, obj_item)
				if(_collide_with != noone){
					if(_collide_with.type == "shield"){
						_collide_with.shield = true
						_collide_with.owner = self
						_collide_with.type = "used"
						_collide_with.image_xscale = 1
						_collide_with.image_yscale = 1
						_collide_with.x = x
						_collide_with.y = y
						if(!shield){
							shield = true
							audio_play_sound(snd_collect, 1, false)
						}
					} else if(_collide_with.type == "heart"){
						points += 1
						instance_destroy(_collide_with)
						audio_play_sound(snd_collect, 1, false)
					}
				}
			
				_collide_with = instance_place(x, y, obj_lightning)
				if(_collide_with != noone){
					points -= 1
					instance_destroy(_collide_with)
					audio_play_sound(snd_crack, 1, false)
					image_index = 6
					part_particles_create(parts, x, y, spark, 20)
				}
			
			}
		}
	
		if(!_colliding){
			y += _dir
			if(_dir > 0){
				if(left){
					image_index = 5
				} else {
					image_index = 2
				}
			}
			_to_move_y -= _dir
		} else {
			y = y + _dir
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
}

// Handle falling out of room
if(y > room_height && respawn_timer == 0) {
    knockout = true;
    respawn_timer = respawn_time_reset;
    
    if(!shield) {
        points -= 1;
        part_particles_create(parts, x, y-10, spark, 10);
        audio_play_sound(snd_die, 1, false);
    }
}

// Player movement logic
if(keyboard_check(left_key)) {
    x_vel -= accel;
    left = true;
} else if(keyboard_check(right_key)) {
    x_vel += accel;
    left = false;
}

// Change image index based on direction pressed and facing
if(keyboard_check(down_key) && !left) {
    image_index = 7; // Right and down
} else if(keyboard_check(down_key) && left) {
    image_index = 9; // Left and down
} else if(keyboard_check(up_key) && !left) {
    image_index = 8; // Right and up
} else if(keyboard_check(up_key) && left) {
    image_index = 10; // Left and up
}

// Game over check
if(points <= 0) {
    global.loser = player;
    audio_play_sound(snd_jump, 1, false);
    room_goto(rm_end);
}