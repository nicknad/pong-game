package main

engine_player_follow_strat :: proc() {
	if b.position.y > p_two.position.y {
		p_two.position.y += p_two.speed;
		
		if p_two.position.y > WINDOW_HEIGHT - p_two.size.y {
			p_two.position.y = WINDOW_HEIGHT - p_two.size.y
		}
	}
	
	if b.position.y < p_two.position.y {
		p_two.position.y -= p_two.speed;
		if p_two.position.y < 0 {
			p_two.position.y = 0
		}
	}	
}