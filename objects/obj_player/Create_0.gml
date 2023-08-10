shake_screen = 5

parts = part_system_create()
part_system_depth(parts, 30)

// lose life
spark = part_type_create()

part_type_shape(spark, pt_shape_star)
part_type_size(spark, 0.1, 0.2, 0, 0)
part_type_speed(spark, 2, 5, -0.1, 0)
part_type_direction(spark, 0, 359, 0, 0)
part_type_color1(spark, c_yellow)
part_type_life(spark, 15, 30)

// hit cloud
poof = part_type_create()

part_type_shape(poof, pt_shape_cloud)
part_type_size(poof, 0.1, 0.2, 0, 0)
part_type_speed(poof, 2, 3, -0.1, 0)
part_type_direction(poof, 0, 359, 0, 0)
part_type_color1(poof, c_white)
part_type_life(poof, 5, 15)

// block
block = part_type_create()

part_type_shape(block, pt_shape_smoke)
part_type_size(block, 0.1, 0.2, 0, 0)
part_type_speed(block, 2, 5, -0.1, 0)
part_type_direction(block, 0, 359, 0, 0)
part_type_color1(block, c_gray)
part_type_life(block, 15, 30)