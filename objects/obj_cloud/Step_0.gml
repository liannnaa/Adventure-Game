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
	}
}