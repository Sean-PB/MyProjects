extends Node2D

var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	if rng.randi_range(0, 1):
		$LeftTree.position = Vector2(rng.randi_range(-10, 35), rng.randi_range(4, 60))
		$LeftTree.show()
	rng.randomize()
	if rng.randi_range(0, 1):
		$RightTree.position = Vector2(rng.randi_range(345, 395), rng.randi_range(4, 60))
		$RightTree.show()
	

#-------------------------------------------------------------------------------
# Delete Strip once off screen
#-------------------------------------------------------------------------------
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
