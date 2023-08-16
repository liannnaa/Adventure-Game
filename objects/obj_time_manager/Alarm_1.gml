if(alpha >= 0){
	alpha -= 0.01
	alarm[1] = 1
} else if (alpha <- 0) {
	alarm[0] = 60*day
	current_phase = "day"
	audio_stop_sound(snd_rain)
	audio_play_sound(snd_day, 1, true)
}