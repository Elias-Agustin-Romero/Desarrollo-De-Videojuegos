extends Node

onready var screen_size = OS.get_window_size()
onready var player = get_node("player")
#onready var last_player_pos = player.get_pos()

func _ready():
#	var canvas_transform = get_viewport().get_canvas_transform()
#	canvas_transform[2] = - player.get_pos() + screen_size / 2
#	get_viewport().set_canvas_transform(canvas_transform)
	pass

#func update_camera():
#	var player_offset = last_player_pos - player.get_pos()
#	last_player_pos = player.get_pos()

#	var canvas_transform = get_viewport().get_canvas_transform()
#	canvas_transform[2] += player_offset
#	get_viewport().set_canvas_transform(canvas_transform)
#	return player_offset