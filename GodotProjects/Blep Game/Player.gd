extends KinematicBody2D

const SPEED = 150
const GRAVITY = 10
const JUMP_POWER = -250
#const FLOOR

var velocity = Vector2()

func _physics_process(delta):
	if Input.is_action_pressed("left"):
		velocity.x = -SPEED
		$AnimatedSprite.animation = "LeftMidBlink"
	elif Input.is_action_pressed("right"):
		velocity.x = SPEED
		$AnimatedSprite.animation = "RightMidBlink"
	else:
		velocity.x = 0
	
	if Input.is_action_just_pressed("up"):
		velocity.y = JUMP_POWER
	
	velocity.y += GRAVITY
	
	velocity = move_and_slide(velocity)
