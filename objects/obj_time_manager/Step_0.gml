if (current_phase == "night" && !rain) {
    rain = true;
    instance_create_layer(room_width/2, 0, layer_get_id("Instances"), obj_rain);
} else if (current_phase == "day" && rain) {
    rain = false;
    var rain_instance = instance_find(obj_rain, 0);
    if (rain_instance != noone) {
        instance_destroy(rain_instance);
    }
}