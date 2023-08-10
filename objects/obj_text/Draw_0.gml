draw_set_halign(fa_left)
draw_set_color(c_white)
draw_set_font(fnt_gameText)

if(room == rm_end){
	if(global.loser == 1){
		text = "Player 2 Won! Press SPACE to play again!"
	} else {
		text = "Player 1 Won! Press SPACE to play again!"
	}
}

draw_text(x, y, text)