var p1 = instance_find(obj_p1, 0);
var p2 = instance_find(obj_p2, 0);

var player_y = 0;

if(p1.y < 0 || p1.y > room_height){
    player_y = p2.y;
} else if(p2.y < 0 || p2.y > room_height){
    player_y = p1.y;
} else {
    player_y = (p1.y + p2.y) / 2;
}

var target_y = player_y - view_height / 2;
y = lerp(y, target_y, 0.1);
y = clamp(y, 0, room_height - view_height);

if (shake_duration > 0) {
    shake_duration -= 1;
    shake_x = random_range(-shake_intensity, shake_intensity);
    shake_y = random_range(-shake_intensity, shake_intensity);
    if (shake_duration <= 0) {
        shake_intensity = 0;
        shake_x = 0;
        shake_y = 0;
    }
}

camera_set_view_pos(view_camera[0], x + shake_x, y + shake_y);
