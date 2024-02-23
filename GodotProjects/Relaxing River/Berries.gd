extends StaticBody2D

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	$AnimatedSprite2D.set_flip_h(rng.randi_range(0, 1))
	$AnimatedSprite2D.frame = rng.randi_range(0, 3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
