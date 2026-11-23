extends Node2D

var snake_body:Array[Vector2i] = []
var snake_direction:Vector2i
var next_direction:Vector2i

func move_snake():
	snake_direction = next_direction
	snake_eat($Environment.apple_pos,grow_snake())
	#if is_game_over():
		#end_game()
		#reset_game()
		#return
	
	#draw_board()

func shrink_snake():
	snake_body.pop_back()

func grow_snake() -> Vector2i:
	var new_head := snake_body[0] + snake_direction
	snake_body.insert(0, new_head)
	return new_head
	

func snake_eat(apple_pos:Vector2i,new_head: Vector2i):
	var ate_apple:= new_head == apple_pos
	if not ate_apple:
		shrink_snake()
		return
	
	print("snake grew")
	apple_pos = $Environment.place_appple(snake_body,$in_game.GRID_SIZE)
