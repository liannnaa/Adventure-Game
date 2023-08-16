// juice
shake_screen = 5

// particle settings
parts = part_system_create()
part_system_depth(parts, 30)

size_min = 0.1
size_max = 0.2
size_incr = 0
size_wiggle = 0


speed_min = 2
speed_max = 3
speed_incr = -0.1
speed_wiggle = 0

direction_min = 0
direction_max = 359
direction_incr = 0
direction_wiggle = 0

life_min = 15
life_max = 30

// Lose Life
spark = create_particle_system(pt_shape_star,
								size_min, size_max, size_incr, size_wiggle,
								speed_min, speed_max, speed_incr, speed_wiggle,
								direction_min, direction_max, direction_incr, direction_wiggle,
								c_white, life_min, life_max)
				
				
// Hit Cloud
poof = create_particle_system(pt_shape_cloud,
								size_min, size_max, size_incr, size_wiggle,
								speed_min, speed_max, speed_incr, speed_wiggle,
								direction_min, direction_max, direction_incr, direction_wiggle,
								c_white, life_min, life_max)

// Block
block = create_particle_system(pt_shape_smoke,
								size_min, size_max, size_incr, size_wiggle,
								speed_min, speed_max, speed_incr, speed_wiggle,
								direction_min, direction_max, direction_incr, direction_wiggle,
								c_gray, life_min, life_max)