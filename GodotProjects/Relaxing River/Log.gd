extends StaticBody2D

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	$Sprite2D.set_flip_h(rng.randi_range(0, 1))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#-------------------------------------------------------------------------------
# Delete Log once off screen
#-------------------------------------------------------------------------------
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
