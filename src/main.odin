package main

import "core:fmt"
import rl "vendor:raylib"

// CONSTANTS
WINDOW_HEIGHT : i32 : 860
WINDOW_WIDTH : i32 : 1024
POINTS_NEEDED_TO_WIN : u32 : 10

// DEFINITIONS
ball :: struct {
	position: rl.Vector2,
	speed: rl.Vector2,
	radius: f32,
	active: bool,
}

player_brick :: struct {
	position: rl.Vector2,
	speed: f32,
	size: rl.Vector2
}

game_state_struct :: struct {
	player_one_points: u32,
	player_two_points: u32,
	game_paused: bool,
	game_over: bool,
}

// Global Variables
b : ball = ball{
	position=rl.Vector2{f32(WINDOW_WIDTH)/2, f32(WINDOW_HEIGHT)/2}, 
	speed=rl.Vector2{5,0}, 
	radius=10, 
	active=true,
	}

p_one : player_brick = player_brick{
	position= rl.Vector2{0, f32(WINDOW_HEIGHT)/2},
	speed=10,
	size=rl.Vector2{20,80},
}

p_two : player_brick = player_brick{
	position= rl.Vector2{f32(WINDOW_WIDTH)-20, f32(WINDOW_HEIGHT)/2},
	speed=10,
	size=rl.Vector2{20,80},
}

game_state : game_state_struct = game_state_struct{
	game_over=false,
	game_paused=false,
	player_one_points=0,
	player_two_points=0,
}


main :: proc() {
	rl.InitWindow(WINDOW_WIDTH, WINDOW_HEIGHT, "Pong Game")
	defer rl.CloseWindow()
	
	rl.SetTargetFPS(60)
	for !rl.WindowShouldClose() {
		
		update_game()
		draw_frame()
	}
}

draw_background :: proc() {
	rl.ClearBackground(rl.BLACK)
	rl.DrawRectangle(0,0,WINDOW_WIDTH,10,rl.GRAY)
	rl.DrawRectangle(0,WINDOW_HEIGHT-10,WINDOW_WIDTH,10,rl.GRAY)		
}

draw_frame :: proc() {
	rl.BeginDrawing()		
	draw_background()
	rl.DrawCircleV(b.position, b.radius, rl.GOLD)
	rl.DrawRectangleV(p_one.position, p_one.size, rl.GREEN)
	rl.DrawRectangleV(p_two.position, p_two.size, rl.GREEN)
	rl.EndDrawing()
}

update_game :: proc() {
	if game_state.game_over {
		return;
	}
	
	if b.active {
		b.position += b.speed
	}
	
	if b.position.x > f32(WINDOW_WIDTH) || b.position.x < 0 {
		b.speed *= -1;
	}		
}