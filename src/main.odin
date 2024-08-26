package main

import "core:fmt"
import "core:strings"
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
	p_one_pts : cstring =  strings.clone_to_cstring(fmt.tprintf("Player One: %d", game_state.player_one_points))
	rl.DrawText(p_one_pts, 75, 200, 32, rl.RED) 
	p_two_pts : cstring  = strings.clone_to_cstring(fmt.tprintf("Player Two: %d", game_state.player_two_points))
	rl.DrawText(p_two_pts, 675, 200, 32, rl.RED) 
}

draw_frame :: proc() {
	rl.BeginDrawing()		
	draw_background()
	rl.DrawCircleV(b.position, b.radius, rl.GOLD)
	rl.DrawRectangleV(p_one.position, p_one.size, rl.GREEN)
	rl.DrawRectangleV(p_two.position, p_two.size, rl.GREEN)
	rl.EndDrawing()
}

determine_ball_collision_with_p_one :: proc() -> bool {
	// if ball is going away from player one side, collision impossible
	if b.speed.x > 0 {
		return false
	}
	
	// if ball is more to the right then the width of player one, collision is impossible
	if (b.position.x + b.radius) > p_one.size.x {
		return false 
	}
	
	// if bool is above the upper value
	if (b.position.y + b.radius) < p_one.position.y{
		return false
	}
	
	// if bool is above the upper value below
	if (b.position.y - b.radius) > (p_one.position.y + p_one.size.y) {
		return false
	}
	
	return true
}

determine_ball_collision_with_p_two :: proc() -> bool {
	if b.speed.x < 0 {
		return false
	}
	
	if 	(b.position.x + b.radius) < WINDOW_WIDTH - p_two.size.x  {
		return false 
	}
	
	if (b.position.y + b.radius) < p_two.position.y {
		return false
	}
	
	if (b.position.y - b.radius) > p_two.position.y + p_two.size.y {
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
	
	if determine_ball_collision_with_p_one() {
		b.speed.x *= -1
		if b.speed.y + p_one.momentum > 15 {
			b.speed.y = 15
		} else if b.speed.y - p_one.momentum < -15 {
			b.speed.y = -15
		} else {
			b.speed.y += p_one.momentum
		}
	}
	
	if determine_ball_collision_with_p_two() {
		b.speed.x *= -1
		
		if b.speed.y + p_two.momentum > 15
		{
			b.speed.y = 15
		} else if b.speed.y - p_two.momentum < -15 {
			b.speed.y = -15
		} else {
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
	
	if b.active {
		b.position += b.speed
	}
	
	player_one_input()
	engine_player_follow_strat()
	// player_two_input()	
	determine_collision()
	determine_point()
}

