function create_particle_system(_shape,
								_size_min, _size_max, _size_incr, _size_wiggle,
								_speed_min, _speed_max, _speed_incr, _speed_wiggle,
								_direction_min, _direction_max, _direction_incr, _direction_wiggle,
								_color, _life_min, _life_max){
	part = part_type_create()

	part_type_shape(part, _shape)
	part_type_size(part, _size_min, _size_max, _size_incr, _size_wiggle)
	part_type_speed(part, _speed_min, _speed_max, _speed_incr, _speed_wiggle)
	part_type_direction(part, _direction_min, _direction_max, _direction_incr, _direction_wiggle)
	part_type_color1(part, _color)
	part_type_life(part, _life_min, _life_max)
	
	return part;
}