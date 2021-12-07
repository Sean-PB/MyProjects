extends Node2D

signal right
signal left

# Deletes when off screen
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_LeftLine_body_entered(body):
	emit_signal("left")


func _on_RightLine_body_entered(body):
	emit_signal("right")
