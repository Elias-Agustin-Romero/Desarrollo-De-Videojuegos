extends KinematicBody2D

onready var animated_sprite = get_node("sprite")
onready var physicsBox = get_parent().get_node("level/PhysicsBox")

export var MAX_SPEED = 400
export var push_speed = 200

signal move

var motion = Vector2(0, 0)

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	var is_moving = Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_up")
	var axis = get_input_axis()
	
	update_animation(motion)
	if is_colliding():
		check_box_collision(axis * push_speed)

	motion = move_and_slide(axis * MAX_SPEED)
	if is_moving:
		emit_signal("move")
		
func get_input_axis():
	var axis = Vector2(0, 0)
	axis.x = Input.is_action_pressed("ui_right") - Input.is_action_pressed("ui_left")
	axis.y = Input.is_action_pressed("ui_down") - Input.is_action_pressed("ui_up")
	return axis.normalized()


func update_animation(motion):
	var animation = "Idle"
	if motion.x > 0:
		animation = "Right"
	elif motion.x < 0:
		animation = "Left"
	elif motion.y > 0:
		animation = "Down"
	elif motion.y < 0:
		animation = "Up"
	if animated_sprite.get_animation() != animation:
		animated_sprite.play(animation)

func check_box_collision(motion):
	
	var box = get_collider()
	if box.get_type() == physicsBox.get_type():
		box.push(motion)

func get_name():
	return "Player"