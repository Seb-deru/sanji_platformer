extends Area2D

var speed = 300 # Pixels per second
var target_position = Vector2(100, -100) # Where to move
var initial_position: Vector2

func _ready() -> void:
	initial_position = position

func _process(delta):
	# Move towards target_position smoothly
	position = position.move_toward(target_position, speed * delta)
	if position == target_position:
		target_position =  initial_position
		
	if position == target_position:
		queue_free()
