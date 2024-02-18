extends CharacterBody2D

signal crash

#-------------------------------------------------------------------------------
# Variables
#-------------------------------------------------------------------------------
var character_file = "user://character.txt"   # Declaring file to save character
var settings_file = "user://settings.txt"
var skin_r
var skin_g
var skin_b
var skin_a
var skin_color
var hair_r
var hair_g
var hair_b
var hair_a
var hair_color
var default_hair = Color(0, 0, 0, 1)
var default_skin = Color(0.74902, 0.560784, 0.403922, 1)
var Settings
var challenge_mode
var swipe
var speed
var moving = true
var drag = 0
var speed_start = 15
var rotation_accel = 0
var playing = false
var leaving_dock = false


# Called when the node enters the scene tree for the first time.
func _ready():
	var Appearance = get_tree().get_root().find_child("CharacterMenu", true, false)
	Appearance.connect("character_confirmed", Callable(self, "load_character"))
	Settings = get_tree().get_root().find_child("SettingsMenu", true, false)
	Settings.connect("settings_confirmed", Callable(self, "load_settings"))
	load_settings()
	load_character()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if leaving_dock and not playing:
		leave_dock(delta)
	if playing:
		# Movement
		rotation_degrees += drag * delta
		rotation_degrees = clamp(rotation_degrees, -45, 45)
# warning-ignore:return_value_discarded
		if moving:
			set_velocity(Vector2(0, -speed).rotated(rotation))
			move_and_slide()
		
		# If challenge mode is on, detect collisions. If collision is a log, play
		# the flash animation, emit crash signal, stop player for a bit, and
		# turn off collision for logs.
		if challenge_mode:
			for i in get_slide_collision_count():
				var collision = get_slide_collision(i)
				var collider = collision.get_collider() # Retrieve the collider node
				if collider and collider.is_in_group("log"): # Check if collider belongs to "logs" group
					emit_signal("crash")
					set_collision_mask_value(3, false) # Turn off collsion for logs
					# Check to see if the flash is already going before stopping player.
					# if it is that means the player has already been stopped and this
					# shouldn't run
					if $Character.animation != "flash":
						$Timer.start()
						moving = false
					$Character.play("flash")


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
# Loads settings from file.
# ------------------------------------------------------------------------------
# Gets called when Player first loads in and when settings are confirmed.
# Check if the file exists. If it doesn't, set the default swipe and speed. If
# the file does exist, open and read in the swipe and speed data into their 
# respective variables. Then, close the file. Finally, set the Character's
# paddle animation speed.
func load_settings():
	if FileAccess.file_exists(settings_file):
		var file = FileAccess.open(settings_file, FileAccess.READ)
		var content = file.get_as_text()
		challenge_mode = int(content.split("/")[1])
		swipe = int(content.split("/")[2])
		speed = int(content.split("/")[3])
		file.close()
	else:
		speed = 200
		swipe = 65
	$Character.set_speed_scale(clamp(((speed + 25) / 100), 1, 1.8))


#-------------------------------------------------------------------------------
# Loads character colors in from file to the character menu
#-------------------------------------------------------------------------------
# Check if there is a character file. If there is, read from it all the values
# and put them into variables. Then put those variables into their respective 
# character part color. Then set the character parts to those colors. Finally,
# set the correct hair length.
# If there is not a character file, set all values to default.
func load_character():
	if FileAccess.file_exists(character_file):
		var file = FileAccess.open(character_file, FileAccess.READ)
		var content = file.get_as_text()
		
		skin_r = float(content.split(",")[0].substr(1))
		skin_g = float(content.split(",")[1])
		skin_b = float(content.split(",")[2])
		skin_a = float(content.split(",")[3])
		skin_color = Color(skin_r, skin_g, skin_b, skin_a)
		
		hair_r = float(content.split(",")[4].substr(1))
		hair_g = float(content.split(",")[5])
		hair_b = float(content.split(",")[6])
		hair_a = float(content.split(",")[7])
		hair_color = Color(hair_r, hair_g, hair_b, hair_a)
		
		$Character.material.set("shader_parameter/New_Skin", skin_color)
		$Character.material.set("shader_parameter/New_Hair", hair_color)
		
		file.close()
	
	else:
		$Character.material.set("shader_parameter/New_Skin", default_skin)
		$Character.material.set("shader_parameter/New_Hair", default_hair)


#-------------------------------------------------------------------------------
# This function takes the player away from the dock and into the starting 
# position for the game.
#-------------------------------------------------------------------------------
# If the player hasn't turned to be straight yet, accelerate their speed and 
# turning rate. Else, just have the player go straight until they reach the
# starting spot. Speed clamped at 100.
func leave_dock(delta):
	if rotation_degrees > 0:
		$Character.play("left")
		rotation_degrees = clamp(rotation_degrees - rotation_accel, 0, 90) # Turn speed
		speed_start = clamp(speed_start + (40 * delta), 0, 100)             # Speed
# warning-ignore:return_value_discarded
		set_velocity(Vector2(0, -speed_start).rotated(rotation))
		move_and_slide()
		rotation_accel += .35 * delta
	else:
		$Character.play("straight")
		playing = true
		leaving_dock = false


#-------------------------------------------------------------------------------
# When the flashing animaiton ends
#-------------------------------------------------------------------------------
# If the animation that finished is flash, change the animation back to straight
# and make the player move again
func _on_Character_animation_finished():
	if $Character.animation == "flash":
		$Character.play("straight")
		set_collision_mask_value(3, true) # Turn on collsion for logs

# Turn collision for logs back on after the post-collision timer timesout
func _on_Timer_timeout():
		moving = true
