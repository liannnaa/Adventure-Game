var pulse_value = pulse_amplitude * sin(pulse_timer);
var pulse_color = make_color_rgb(255, 255 - 255 * pulse_value, 255 - 255 * pulse_value);


draw_sprite(spr_back, 0, hb_x, hb_y);

if (points <= max_points * 0.3) {
    draw_sprite_ext(spr_health, 0, hb_x, hb_y, (points/max_points) * hb_w, 1, 0, pulse_color, 1);
} else {
    draw_sprite_stretched(spr_health, 0, hb_x, hb_y, (points/max_points) * hb_w, hb_h);
}

draw_sprite(spr_bar, 0, hb_x, hb_y);
