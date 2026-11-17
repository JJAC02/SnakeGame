extends Node
const SNAKE = 0
const APPLE = 1
var apple_pos
var snake_body = [Vector2(5,10),Vector2(4,10),Vector2(3,10)]
var snake_direction = Vector2(1,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	apple_pos = place_apple()
	draw_apple()
	draw_snake()

func place_apple():
	randomize()
	var x = randi() % 20
	var y = randi() % 20
	return Vector2i(x,y)

func draw_apple():
	$GameArea.set_cell(apple_pos,APPLE,Vector2i(0,0))
	pass

func draw_snake():
	for block in snake_body:
		$GameArea.set_cell(Vector2i(block),SNAKE,Vector2i(7,0))
	pass

func move_snake():
	var body_copy = snake_body.slice(0,snake_body.size() - 1)
	var new_head = body_copy[0] + snake_direction
	body_copy.insert(0,new_head)
	snake_body = body_copy
	

func _on_timer_timeout() -> void:
	move_snake()
	draw_apple()
	draw_snake()
