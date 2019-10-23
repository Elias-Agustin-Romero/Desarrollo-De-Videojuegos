extends KinematicBody2D

onready var animated_sprite = get_node("AnimatedSprite")

var direction = Vector2()

const MAX_SPEED = 400

var speed = 0
var velocity = Vector2()

var world_target_pos = Vector2()
var target_direction = Vector2()
var is_moving = false


var type
var grid

func _ready():
	grid = get_parent()
	type = grid.PLAYER
	set_process(true)

func _process(delta):
	direction = Vector2()
	speed = 0
	
	if Input.is_action_pressed("move_up"):
		direction.y = -1
	elif Input.is_action_pressed("move_down"):
		direction.y = 1
		
	if Input.is_action_pressed("move_left"):
		direction.x = -1
	elif Input.is_action_pressed("move_right"):
		direction.x = 1
	
	if not is_moving and direction != Vector2():
		target_direction = direction.normalized()
		
		if grid.is_cell_vacant(get_pos(), Vector2(abs(direction.x), abs(direction.y))):
			world_target_pos = grid.update_child_pos(get_pos(), direction, type)
			is_moving = true
	elif is_moving:
		speed = MAX_SPEED
		velocity = speed * target_direction * delta
		
		var pos = get_pos()
		#var distance_to_target = Vector2(abs(world_target_pos.x - pos.x), abs(world_target_pos.y - pos.y))
		var distance_to_target = get_pos().distance_to(world_target_pos)
		var move_distance = velocity.length()
		
		#if abs(velocity.x) > distance_to_target.x:
		#	velocity.x = distance_to_target.x * target_direction.x
		#	is_moving = false
		#if abs(velocity.y) > distance_to_target.y:
		#	velocity.y = distance_to_target.y * target_direction.y
		#	is_moving = false
		if distance_to_target < move_distance:
			velocity = target_direction * distance_to_target
			is_moving = false
		
		move(velocity)
		
	update_animation(direction)
	
	
	
	
	if direction != Vector2():
		emit_signal("move")
		

func update_animation(motion):
	var animation = "Idle"
	
	if Input.is_action_pressed("move_right"):
		animation = "Right"
	elif Input.is_action_pressed("move_left"):
		animation = "Left"
	elif Input.is_action_pressed("move_down"):
		animation = "Down"
	elif Input.is_action_pressed("move_up"):
		animation = "Up"
	else:
		animation = "Idle"
	if animated_sprite.get_animation() != animation:
		animated_sprite.play(animation)