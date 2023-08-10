// cloud generator
var num_clouds = instance_number(obj_cloud)

frames_since_cloud += 1

if(frames_since_cloud > frames_bt_cloud | num_clouds < 5){
	if(num_clouds < max_clouds){
		var new_cloud = instance_create_layer(random_range(30, room_width - 30), random_range(80, room_height - 30), "Instances", obj_cloud)
		with(new_cloud){
			var tries = 0
			while(tries < 3000 && collision_rectangle(x-8, 7-8, x+8, y+16, obj_solid, false, true) != noone){
				x = random_range(30,  room_width - 30)
				y = random_range(80, room_height - 30)
				tries += 1
			}
		}
		num_clouds += 1
	}
	frames_since_cloud = 0
}

// item generator
var num_items = instance_number(obj_item)

if(num_items < max_items){
	frames_since_chance += 1
	if(frames_since_chance > max_chance){
		var spawn = irandom(chance)
	
		if(spawn == 1){
			instance_create_depth(random_range(30, room_width - 30), random_range(80, room_height - 30), -999, obj_item)
		}
	
		frames_since_chance = 0
	}
}

// lightning generator
frames_since_lightning += 1
if(frames_since_lightning > max_lightning){
	var spawn = irandom(chance_lightning)
	
	if(spawn == 1){
		instance_create_depth(random_range(30, room_width - 30), 0, -999, obj_lightning)
	}
	
	frames_since_lightning = 0
}