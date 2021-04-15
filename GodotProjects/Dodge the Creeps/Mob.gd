extends RigidBody2D

export var min_speed = 150   # Minimum speed range (exported to Inspector)
export var max_speed = 250   # Maximum speed range (exported to Inspector)

func _ready():
	var mob_types = $AnimatedSprite.frames.get_animation_names()  # Getting list of names from frames ["walk", "swim", "fly"]
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]  # Setting animation as a random pick in the list ^
	# Use randomize to get different random numbers everytime you run the scene.
	# We'll randomize in the main scene though so not needed here.


func _on_VisibilityNotifier2D_screen_exited(): # Signal from VisiblityNotifier2D
	queue_free()                               # Delete object once off screen
