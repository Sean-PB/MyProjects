extends CanvasLayer

var swipe_direction = 0

func _input(event):
	if event is InputEventScreenDrag:
		# Maybe have it pass a relative threshold so that taps don't get counted as swipes
		if event.relative.x < 0 and event.speed.x < -20:      # Left
			swipe_direction = -1
		elif event.relative.x > 0 and event.speed.x > 20:     # Right
			swipe_direction = 1
	else:
		swipe_direction = 0
		
