if(alpha <= 0.95){
	alpha += 0.01
	alarm[0] = 1
} else if alpha >= 0.95 {
	alarm[1] = 60*night
	current_phase = "night"
	audio_stop_sound(snd_day)
	audio_play_sound(snd_rain, 1, true)
}