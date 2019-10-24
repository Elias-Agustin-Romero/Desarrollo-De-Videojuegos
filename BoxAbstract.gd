extends KinematicBody2D

func push(velocity):
	move_and_slide(velocity)
	
func get_name():
	return "Box"