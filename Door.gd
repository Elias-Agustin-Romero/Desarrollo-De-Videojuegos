extends StaticBody2D

func _on_Switch_pressed():
	set_collision_mask_bit(0, false)
	set_layer_mask_bit(0, false)


func _on_Switch_unpressed():
	set_collision_mask_bit(0, true)
	set_layer_mask_bit(0, true)