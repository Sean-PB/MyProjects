extends KinematicBody2D


var character_file = "user://character.txt"   # Declaring file to save character
var skin
var hair
var animation
var frame
var sensitivity = 5
var drag = 0
var speed_start = 15
var rotation_accel = 0
var playing = false
var speed = 35


# Called when the node enters the scene tree for the first time.
func _ready():
	var Appearance = get_tree().get_root().find_node("CharacterSelection", true, false)
	Appearance.connect("character_confirmed", self, "load_character")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if playing == true:
		rotation_degrees += drag * delta
		rotation_degrees = clamp(rotation_degrees, -30, 30)
		move_and_slide(Vector2(0, -speed).rotated(rotation))

# Swiping functionality
func _input(event):
	if playing: # To make sure you can't set drag before starting
		# Finding out how much to rotate player based on drag
		if event is InputEventScreenDrag:
			drag = event.relative.x * sensitivity
		# Stopping rotation once player stops dragging
		elif event is InputEventScreenTouch and not event.is_pressed():
			drag = 0


func load_character():
	var f = File.new()
	if f.file_exists(character_file):
		f.open(character_file, File.READ)
		var content = f.get_as_text()
		skin = content.split("/")[0]
		hair = content.split("/")[1]
		f.close()
		
		animation = $Skin.animation
		frame = $Skin.frame
		animation.erase(animation.length() - 1, 1)
		animation += skin
		$Skin.animation = animation
		$Skin.frame = frame
		
		$Skin/Hair.show()
		if hair == "bald":
			$Skin/Hair.hide()
		elif hair == "black":
			$Skin/Hair.frame = 0
		elif hair == "brown":
			$Skin/Hair.frame = 1
		elif hair == "blonde":
			$Skin/Hair.frame = 2
		elif hair == "red":
			$Skin/Hair.frame = 3
	else:
		$Skin.frame = 3
		$Skin/Hair.hide()


# This function takes the player away from the dock and into the starting 
# position for the game"
#----------------------------------------------------------------------------------------------
# If the player hasn't turned to be straight yet, accelerate their speed and 
# turning rate. Else, just have the player go straight until they reach the
# starting spot.
func leave_dock(delta):
	if rotation_degrees > 0:
		$Skin.play("left" + skin)
		rotation_degrees = clamp(rotation_degrees - rotation_accel, 0, 90) # Turn speed
		speed_start = clamp(speed_start + (40 * delta), 0, 50)             # Speed
		move_and_slide(Vector2(0, -speed_start).rotated(rotation))
		rotation_accel += .35 * delta
	else:
		$Skin.play("straight" + skin)
		move_and_slide(Vector2(0, -speed).rotated(rotation))
