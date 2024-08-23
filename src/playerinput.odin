package main

import rl "vendor:raylib"

player_one_input :: proc() {
	if rl.IsKeyReleased(p_one_up) {
		p_one.key_up =  false
	}
	
	if rl.IsKeyPressed(p_one_up) || p_one.key_up {
		p_one.position.y -= p_one.speed;
		p_one.key_up = true
		if p_one.position.y < 0 {
			p_one.position.y = 0
		}
		
		if p_one.momentum <= 10 {
			p_one.momentum += 1
		}
	}
	
	if rl.IsKeyReleased(p_one_down) {
		p_one.key_down =  false
		p_one.momentum = 0
	}
	
		
	if rl.IsKeyPressed(p_one_down) || p_one.key_down {
		p_one.position.y += p_one.speed
		p_one.key_down =  true
		
		if p_one.position.y > WINDOW_HEIGHT - p_one.size.y {
			p_one.position.y = WINDOW_HEIGHT - p_one.size.y
		}
		
		if p_one.momentum >= -10 {
			p_one.momentum -= 1
		}
	}
}

player_two_input :: proc() {
	
	if rl.IsKeyReleased(p_two_up) {
		p_two.key_up =  false
	}
	
	if rl.IsKeyPressed(p_two_up) || p_two.key_up{
		p_two.position.y -= p_two.speed;
		p_two.key_up = true
		
		if p_two.position.y < 0 {
			p_two.position.y = 0
		}
	}
	
	if rl.IsKeyReleased(p_two_down) {
		p_two.key_down =  false
	}
	
		
	if rl.IsKeyPressed(p_two_down) || p_two.key_down{
		p_two.position.y += p_two.speed;
		p_two.key_down =  true
		
		if p_two.position.y > WINDOW_HEIGHT - p_two.size.y {
			p_two.position.y = WINDOW_HEIGHT - p_two.size.y
		}
	}
}