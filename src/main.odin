package main

import "core:fmt"
import rl "vendor:raylib"
import b2 "vendor:box2d"

main :: proc() {
	rl.InitWindow(1000, 860, "Test raylib")
	defer rl.CloseWindow()

	world_id := DefineWorld()
	defer b2.DestroyWorld(world_id)

	ball_id := DefineBall(world_id)
	defer b2.DestroyBody(ball_id)

	rl.SetTargetFPS(80)
	for !rl.WindowShouldClose() {
		dt := rl.GetFrameTime()
		b2.World_Step(world_id, dt, 8)

		rl.BeginDrawing()
		rl.ClearBackground(rl.BLACK)
		
		p := b2.Body_GetWorldPoint(ball_id, {0,0})
		sphere := rl.Rectangle{p.x, p.y, 10, 10}
		rl.DrawRectanglePro(sphere, 0, 0, rl.GOLD)

		rl.EndDrawing()
	}
}

DefineWorld :: proc() -> b2.WorldId {
	world_def := b2.DefaultWorldDef()
	world_id := b2.CreateWorld(world_def)

	return world_id;
}

DefineBall :: proc(#by_ptr world_id: b2.WorldId) -> b2.BodyId {
	body_def := b2.DefaultBodyDef()
	body_def.type = .dynamicBody
	body_def.position = {500, 430}
	body_def.linearVelocity = {-30, 0}
	ball_id := b2.CreateBody(world_id ,body_def)
	
	return ball_id
}