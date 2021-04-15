extends Area2D

signal hit                 # Custom signal

export var speed = 400     # Player speed (pixels/sec). 'export' puts variable in the Inspector tab
var screen_size            # Size of the game window
onready var joystick = get_parent().get_node("Joystick/Joysitck_Button")

func _ready():             # Called when the node enters the scene tree
	screen_size = get_viewport_rect().size
	hide()

func _process(delta):      # Called every frame
	# Taking input
	var velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	
	if joystick.get_value().x != 0:
		velocity.x = joystick.get_value().x
	if joystick.get_value().x != 0:
		velocity.y = joystick.get_value().y

	# Moving player and animation
	if velocity.length() > 0: # Length seems like its the combination of both the x and y: (1, 1).length = 2
		velocity = velocity.normalized() * speed   # Normalized seems to set the velocity lenth to 1
		$AnimatedSprite.play()  # '$' is shorthand for 'get_node()' for the relative path from current node so...
	else:                       # ...
		$AnimatedSprite.stop()  # that <-- is the same as get_node("AnimatedSprite").play()
	
	# Clamping player (AKA restruicting to a given range (prevent it from leaving screen))
	position += velocity * delta
	position.x = clamp(position.x, 28, screen_size.x - 28)   # .clamp(value, min, max)
	position.y = clamp(position.y, 35, screen_size.y - 35)
	
	# Playing correct animations depending on direction
	if joystick.get_value().x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	if joystick.get_value().y > 0.7:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0
	if joystick.get_value().y < -0.7:
		$AnimatedSprite.animation = "up"


func _on_Player_body_entered(body):  # This function is connected to the signal...
									 # So when the signal is sent this code runs
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)  # Disables the players collision so the...
													  # hit signal isn't sent more than once

func start(pos):                                      # To start or restart game
	position = pos
	$AnimatedSprite.animation = "up"
	show()
	$CollisionShape2D.disabled = false                # Enables the players collision
