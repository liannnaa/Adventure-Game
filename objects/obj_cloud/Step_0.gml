if(level < 4){
	cloud_timer += 1

	if(cloud_timer > max_timer){
		if(level == 1){
			sprite_index = spr_cloud2
		} else if(level == 2){
			sprite_index = spr_cloud3
		} else if(level == 3){
			sprite_index = spr_cloud4
		}
	
		level += 1
		cloud_timer = 0
		
		x = clamp(x, sprite_width / 2, room_width - sprite_width / 2);
	}
}

switch (cloud_type) {
    case 0:  // Normal cloud
        image_index = 0
        break;
    case 1:  // Moving cloud
        image_index = 1
        if (x - sprite_width / 2 <= 0 || x + sprite_width / 2 >= room_width) {
            moving_dir *= -1;  // Reverse direction
        } else {
            moving_change_timer += 1;
            if (moving_change_timer >= moving_change_frequency) {
                moving_dir = sign(random(2) - 1);  // Change direction
                moving_change_timer = 0;  // Reset timer
            }
        }

        x += moving_speed * moving_dir
        break;
    case 2:  // Extra bouncy cloud
        image_index = 2
        if (place_meeting(x, y, obj_player)) {
            var _player = instance_place(x, y, obj_player)
            _player.y_vel = -extra_bounce;  // Apply extra bounce to the player
            if(level == 4){
                cloud_type = 0
            }
        }
        break;
}

