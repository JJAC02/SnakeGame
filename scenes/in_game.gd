extends Control

const GRID_SIZE := 20
const SNAKE := 0
const APPLE := 1
const apple_atlas:= Vector2i(0,0)
const snake_atlas:= Vector2i(7,0)
var apple_pos:Vector2i
var snake_body:Array[Vector2i] = []
var snake_direction:Vector2i
var next_direction:Vector2i
var is_paused := false

@onready var board: TileMapLayer = $GameArea
@onready var timer: Timer = $Timer
@onready var environment: Node2D = $Environment



func iniateGame() -> void:
	apple_pos = Vector2i( 9,10)
	snake_body = [Vector2i(5,10),Vector2i(4,10),Vector2i(3,10)]
	snake_direction = Vector2i.ZERO
	next_direction = Vector2i.ZERO
	timer.wait_time = 0.1
	

func _ready() -> void:
	randomize()
	iniateGame()
	#apple_pos = place_apple()
	draw_board()

func place_apple() -> Vector2i:
	var available:= []
	for y in range(GRID_SIZE):
		for x in range(GRID_SIZE):
			var spot:= Vector2i(x, y)
			if spot not in snake_body:
				available.append(spot)
	if available.is_empty():
		return Vector2i(-1,-1)
	return available.pick_random()

func draw_board()-> void:
	board.clear()
	if apple_pos.x >= 0:
		board.set_cell(apple_pos,APPLE,apple_atlas)
	for block in snake_body:
		board.set_cell(block,SNAKE,snake_atlas)


#func draw_apple():
	#board.set_cell(apple_pos,APPLE,apple_atlas)
	#pass
#
#func draw_snake():
	#for block in snake_body:
		#board.set_cell(Vector2i(block),SNAKE,Vector2i(7,0))
	#pass

func move_snake():
	if next_direction == Vector2i.ZERO:
		return
	
	snake_direction = next_direction
	snake_eat(grow_snake())
	if is_game_over():
		end_game()
		reset_game()
		return
	
	draw_board()

func shrink_snake():
	snake_body.pop_back()
	

func is_game_over() -> bool:
	var head:= snake_body[0]
	if head.x < 0 or head.x>= GRID_SIZE:
		return true
	if head.y < 0 or head.y>= GRID_SIZE:
		return true
	
	return head in snake_body.slice(1)

func grow_snake() -> Vector2i:
	var new_head := snake_body[0] + snake_direction
	snake_body.insert(0, new_head)
	return new_head
	

func snake_eat(new_head: Vector2i):
	var ate_apple:= new_head == apple_pos
	if not ate_apple:
		shrink_snake()
		return
	
	print("snake grew")
	apple_pos = place_apple()

func reset_game():
	iniateGame()
	draw_board()
	

func end_game():
	print("Lose")
	get_tree().change_scene_to_file("res://scenes/end_scene.tscn")
	

func _on_timer_timeout() -> void:
	move_snake()
	#draw_apple()
	#draw_snake()

func try_direction(direction:Vector2i)->void:
	if direction != -snake_direction:
		next_direction = direction

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up"):
		try_direction(Vector2i.UP)
	if event.is_action_pressed("ui_down"):
		try_direction(Vector2i.DOWN)
	if event.is_action_pressed("ui_left"):
		try_direction(Vector2i.LEFT)
	if event.is_action_pressed("ui_right"):
		try_direction(Vector2i.RIGHT)


func _process(delta: float) -> void:
	print(delta)
	pass
