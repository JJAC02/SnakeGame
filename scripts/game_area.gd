extends TileMapLayer

const SNAKE := 0
const APPLE := 1
const apple_atlas:= Vector2i(0,0)
const snake_atlas:= Vector2i(7,0)

func draw_board(snake_body, apple_pos)-> void:
	clear()
	if apple_pos.x >= 0:
		set_cell(apple_pos,APPLE,apple_atlas)
	for block in snake_body:
		set_cell(block,SNAKE,snake_atlas)
