package main

import rl "vendor:raylib"

ball :: struct {
	position: rl.Vector2,
	speed: rl.Vector2,
	radius: f32,
	active: bool,
}

player_brick :: struct {
	position: rl.Vector2,
	speed: f32,
	momentum:f32,
	size: rl.Vector2,
	key_up : bool,
	key_down : bool,
}

game_state_struct :: struct {
	player_one_points: u32,
	player_two_points: u32,
	game_paused: bool,
	game_over: bool,
}