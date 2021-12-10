extends KinematicBody2D


var character_file = "user://character.txt"   # Declaring file to save character
var settings_file = "user://settings.txt"
var skin
var hair
var animation
var frame
var swipe
var speed
var Settings
var drag = 0
var speed_start = 15
var rotation_accel = 0
var playing = false


# Called when the node enters the scene tree for the first time.
func _ready():
	var Appearance = get_tree().get_root().find_node("CharacterSelection", true, false)
	Appearance.connect("character_confirmed", self, "load_character")
	Settings = get_tree().get_root().find_node("SettingsMenu", true, false)
	Settings.connect("settings_confirmed", self, "load_settings")
	load_settings()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if playing == true:
		rotation_degrees += drag * delta
		rotation_degrees = clamp(rotation_degrees, -30, 30)
# warning-ignore:return_value_discarded
		move_and_slide(Vector2(0, -speed).rotated(rotation))

# Swiping functionality
func _input(event):
	if playing: # To make sure you can't set drag before starting
		# Finding out how much to rotate player based on drag
		if event is InputEventScreenDrag:
			drag = event.relative.x * swipe
		# Stopping rotation once player stops dragging
		elif event is InputEventScreenTouch and not event.is_pressed():
			drag = 0


# ------------------------------------------------------------------------------
# Loads settings from file
# ------------------------------------------------------------------------------
# Check if the file exists. If it doesn't, set the default swipe and speed. If
# the file does exist, open and read in the swipe and speed data into their 
# respective variables. Finally, close the file.
func load_settings():
	var f = File.new()
	if f.file_exists(settings_file):
		f.open(settings_file, File.READ)
		var content = f.get_as_text()
		swipe = int(content.split("/")[2])
		speed = int(content.split("/")[3])
		f.close()
	else:
		swipe = 15
		speed = 40


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


#-------------------------------------------------------------------------------
# This function takes the player away from the dock and into the starting 
# position for the game.
#-------------------------------------------------------------------------------
# If the player hasn't turned to be straight yet, accelerate their speed and 
# turning rate. Else, just have the player go straight until they reach the
# starting spot. Speed clamped at 50.
func leave_dock(delta):
	if rotation_degrees > 0:
		$Skin.play("left" + skin)
		rotation_degrees = clamp(rotation_degrees - rotation_accel, 0, 90) # Turn speed
		speed_start = clamp(speed_start + (40 * delta), 0, 50)             # Speed
# warning-ignore:return_value_discarded
		move_and_slide(Vector2(0, -speed_start).rotated(rotation))
		rotation_accel += .35 * delta
	else:
		$Skin.play("straight" + skin)
# warning-ignore:return_value_discarded
		move_and_slide(Vector2(0, -speed).rotated(rotation))
