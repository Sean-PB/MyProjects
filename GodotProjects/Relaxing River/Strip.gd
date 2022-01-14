extends Node2D


# --------------------------------------------------------------------------------------------------
# Variables
# --------------------------------------------------------------------------------------------------
var rng = RandomNumberGenerator.new()


# --------------------------------------------------------------------------------------------------
# Spawns trees on strip when strip is first created
# --------------------------------------------------------------------------------------------------
# Randomize, then decide if the left side of the strip will have a tree. If so,
# rng the scale and the position and show the tree. Do the same with the right
# side.
func _ready():
	rng.randomize()
	if rng.randi_range(0, 1):
		var left_scale = rng.randf_range(1.5, 2.25)
		$LeftTree.scale.x = left_scale
		$LeftTree.scale.y = left_scale
		$LeftTree.position = Vector2(rng.randi_range(-10, 35), rng.randi_range(4, 60))
		$LeftTree.show()
	rng.randomize()
	if rng.randi_range(0, 1):
		var right_scale = rng.randf_range(1.5, 2.25)
		$RightTree.scale.x = right_scale
		$RightTree.scale.y = right_scale
		$RightTree.position = Vector2(rng.randi_range(345, 395), rng.randi_range(4, 60))
		$RightTree.show()
	

#-------------------------------------------------------------------------------
# Delete Strip once off screen
#-------------------------------------------------------------------------------
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
