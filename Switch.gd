extends Area2D


onready var animated_sprite = get_node("animation")
onready var box = get_parent().get_node("level/PhysicsBox")

signal pressed
signal unpressed

func _ready():
	connect("body_enter", self, "_on_body_entered")
	connect("body_exit", self, "_on_body_exited")

func _on_body_entered(body):
	if not body.get_name() == "Box":
		return
	animated_sprite.play("pressed")
	emit_signal("pressed")
	
func _on_body_exited(body):
	if not body.get_name() == "Box":
		return
	animated_sprite.play("unpressed")
	emit_signal("unpressed")