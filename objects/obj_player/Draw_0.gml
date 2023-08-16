part_system_drawit(parts);

if(glow_timer > 0){
    gpu_set_blendmode(bm_add);
    for(var c = 0; c < 360; c += 18){
        draw_sprite_ext(sprite_index, image_index, x + lengthdir_x(4, c), y + lengthdir_y(4, c), image_xscale, image_yscale, image_angle, image_blend, image_alpha * 0.25);
    }
    gpu_set_blendmode(bm_normal);
}
draw_self();

item_collected = false;
