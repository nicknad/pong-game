package main

import rl "vendor:raylib"

b : ball = ball{
	position=rl.Vector2{WINDOW_WIDTH/2, WINDOW_HEIGHT/2}, 
	speed=rl.Vector2{5,0}, 
	radius=10, 
	active=true,
	}

p_one : player_brick = player_brick{
	position= rl.Vector2{0, (WINDOW_HEIGHT/2)-(BRICK_HEIGHT/2)},
	speed=10,
	size=rl.Vector2{BRICK_WIDTH,BRICK_HEIGHT},
	momentum=0,
	key_up=false,
	key_down=false,
}

p_two : player_brick = player_brick{
	position= rl.Vector2{WINDOW_WIDTH-BRICK_WIDTH, (WINDOW_HEIGHT/2)-(BRICK_HEIGHT/2)},
	speed=10,
	size=rl.Vector2{BRICK_WIDTH,BRICK_HEIGHT},
	key_up=false,
	key_down=false,
	momentum=0,
}

game_state : game_state_struct = game_state_struct{
	game_over=false,
	game_paused=false,
	player_one_points=0,
	player_two_points=0,
}
