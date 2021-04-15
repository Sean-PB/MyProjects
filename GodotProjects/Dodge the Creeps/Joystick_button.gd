extends TouchScreenButton

func _inpput(event):
	if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed()):
		set_global_position(event.position)
