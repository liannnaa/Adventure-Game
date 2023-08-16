cloud_timer = 0
max_timer = 200
level = 1

sprite_index = spr_cloud1
image_speed = 0
image_index = 0

cloud_type = choose(0, 0, 0, 1, 2);  // 0 for normal, 1 for moving, 2 for extra bouncy
moving_speed = 2;
extra_bounce = 7;

moving_dir = sign(random(2) - 1)
moving_change_timer = 0
moving_change_frequency = 60