function handle_collisions(_dir, _player, _to_move_y){
	with(_player){
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
	
			if(!colliding){
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
}