image_xscale = .5
image_yscale = .5

chance = irandom_range(1, 2)
type = "none"
shield = false
owner = noone

shield_timer = 0
max_timer = 500

if(chance == 1){
	type = "shield"
	sprite_index = spr_shield
} else if(chance == 2){
	type = "heart"
	sprite_index = spr_heart
}