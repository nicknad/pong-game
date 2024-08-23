package main

import "core:fmt"
import rl "vendor:raylib"


main :: proc() {
	rl.InitWindow(WINDOW_WIDTH_I32, WINDOW_HEIGHT_I32, "Pong Game")
	defer rl.CloseWindow()
	
	rl.SetTargetFPS(50)
	for !rl.WindowShouldClose() {
		
		update_game()
		draw_frame()
	}
}

draw_background :: proc() {
	rl.ClearBackground(rl.BLACK)
	rl.DrawRectangle(0,0,WINDOW_WIDTH_I32,10,rl.GRAY)
	rl.DrawRectangle(0,WINDOW_HEIGHT_I32-10,WINDOW_WIDTH_I32,10,rl.GRAY)		
}

draw_frame :: proc() {
	rl.BeginDrawing()		
	draw_background()
	rl.DrawCircleV(b.position, b.radius, rl.GOLD)
	rl.DrawRectangleV(p_one.position, p_one.size, rl.GREEN)
	rl.DrawRectangleV(p_two.position, p_two.size, rl.GREEN)
	rl.EndDrawing()
}

determine_collision_with_p_one :: proc() -> bool {
	if b.speed.x > 0 {
		return false
	}
	
	if b.position.x > p_one.size.x {
		return false 
	}
	
	if b.position.y > p_one.position.y - (p_one.size.y / 2){
		return false
	}
	
	if b.position.y < p_one.position.y + (p_one.size.y / 2){
		return false
	}
	
	return true
}

determine_collision_with_p_two :: proc() -> bool {
	if b.speed.x < 0 {
		return false
	}
	
	if 	b.position.x < WINDOW_WIDTH- p_two.size.x  {
		return false 
	}
	
	if b.position.y > p_two.position.y - (p_two.size.y / 2){
		return false
	}
	
	if b.position.y < p_two.position.y + (p_two.size.y / 2) {
		return false
	}
	
	return true
}

determine_collision :: proc() {
	if b.position.y < 10 {
		b.speed.y *= -1
		b.position.y = 10
	}
	
	if b.position.y > WINDOW_HEIGHT - 10 {
		b.speed.y *= -1
		b.position.y = WINDOW_HEIGHT - 10
	}
	
	if determine_collision_with_p_one() {
		b.speed.x *= -1
		if b.speed.y < 20 || b.speed.y > -20 {
			b.speed.y += p_one.momentum
		}
	}
	
	if determine_collision_with_p_two() {
		b.speed.x *= -1
		if b.speed.y < 20 || b.speed.y > -20 {
			b.speed.y += p_two.momentum
		}
	}
}

determine_point :: proc() {
	if b.position.x < -40 {
		game_state.player_two_points += 1
		b.position =rl.Vector2{WINDOW_WIDTH/2, WINDOW_HEIGHT/2}
		b.speed.x *= -1
	}
	
	if b.position.x > WINDOW_WIDTH + 40 {
		game_state.player_one_points += 1
		b.position =rl.Vector2{WINDOW_WIDTH/2, WINDOW_HEIGHT/2}
		b.speed.x *= -1
	}
}


update_game :: proc() {
	if game_state.game_over {
		return;
	}
	
	determine_collision()
	
	player_one_input()
	player_two_input()	
	determine_point()
	
	if b.active {
		b.position += b.speed
	}
}

