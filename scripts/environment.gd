extends Node2D

## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
	#
func place_apple(snake_body, GRID_SIZE) -> Vector2i:
	var available:= []
	for y in range(GRID_SIZE):
		for x in range(GRID_SIZE):
			var spot:= Vector2i(x, y)
			if spot not in snake_body:
				available.append(spot)
	if available.is_empty():
		return Vector2i(-1,-1)
	return available.pick_random()
