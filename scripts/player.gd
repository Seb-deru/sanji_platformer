extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var throwable = preload("res://scenes/hook.tscn")

func _physics_process(delta: float) -> void:
	handle_gravity(delta)
	handle_jump()
	move()
	handle_throw()

func handle_gravity(delta: float):
	if not is_on_floor():
		velocity += get_gravity() * delta

func handle_jump():	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

func move():
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func handle_throw():
	if Input.is_action_just_pressed("throw"):
		var instance = throwable.instantiate()
		var target_position_x = 100
		if animated_sprite.flip_h:
			target_position_x = -100
		
		instance.target_position = Vector2(target_position_x, 1)
		
		add_child(instance)
		instance.position = Vector2(1, 6)
