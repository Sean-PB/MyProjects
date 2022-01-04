extends KinematicBody2D

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
	var Appearance = get_tree().get_root().find_node("CharacterMenu", true, false)
	Appearance.connect("character_confirmed", self, "load_character")
	Settings = get_tree().get_root().find_node("SettingsMenu", true, false)
	Settings.connect("settings_confirmed", self, "load_settings")
	load_settings()
	load_character()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if leaving_dock and not playing:
		leave_dock(delta)
	if playing:
		# Movement
		rotation_degrees += drag * delta
		rotation_degrees = clamp(rotation_degrees, -30, 30)
# warning-ignore:return_value_discarded
		if moving:
			move_and_slide(Vector2(0, -speed).rotated(rotation))
		
		# If challenge mode is on, detect collisions. If collision is a log, play
		# the flash animation, emit crash signal, stop player for a bit, and
		# turn off collision for logs.
		if challenge_mode:
			for i in get_slide_count():
				var collision = get_slide_collision(i)
				if collision.collider.name == "Log" or collision.collider.name.begins_with("@Log"):
					emit_signal("crash")
					set_collision_mask_bit(2, false) # Turn off collsion for logs
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
	var f = File.new()
	if f.file_exists(settings_file):
		f.open(settings_file, File.READ)
		var content = f.get_as_text()
		challenge_mode = int(content.split("/")[1])
		swipe = int(content.split("/")[2])
		speed = int(content.split("/")[3])
		f.close()
	else:
		swipe = 35
		speed = 125
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
	var f = File.new()
	if f.file_exists(character_file):
		f.open(character_file, File.READ)
		var content = f.get_as_text()
		skin_r = float(content.split(",")[0])
		skin_g = float(content.split(",")[1])
		skin_b = float(content.split(",")[2])
		skin_a = float(content.split(",")[3])
		skin_color = Color(skin_r, skin_g, skin_b, skin_a)
		hair_r = float(content.split(",")[4])
		hair_g = float(content.split(",")[5])
		hair_b = float(content.split(",")[6])
		hair_a = float(content.split(",")[7])
		hair_color = Color(hair_r, hair_g, hair_b, hair_a)
		
		$Character.material.set("shader_param/NEWSKIN", skin_color)
		$Character.material.set("shader_param/NEWHAIR", hair_color)
	
	else:
		$Character.material.set("shader_param/NEWSKIN", default_skin)
		$Character.material.set("shader_param/NEWHAIR", default_hair)


#-------------------------------------------------------------------------------
# This function takes the player away from the dock and into the starting 
# position for the game.
#-------------------------------------------------------------------------------
# If the player hasn't turned to be straight yet, accelerate their speed and 
# turning rate. Else, just have the player go straight until they reach the
# starting spot. Speed clamped at 50.
func leave_dock(delta):
	if rotation_degrees > 0:
		$Character.play("left")
		rotation_degrees = clamp(rotation_degrees - rotation_accel, 0, 90) # Turn speed
		speed_start = clamp(speed_start + (40 * delta), 0, 50)             # Speed
# warning-ignore:return_value_discarded
		move_and_slide(Vector2(0, -speed_start).rotated(rotation))
		rotation_accel += .35 * delta
	else:
		$Character.play("straight")
		playing = true
		leaving_dock = false


#-------------------------------------------------------------------------------
# When the flashing animaiton ends
#-------------------------------------------------------------------------------
# If the animation that finished is flash, change the animation back to straight 
# and turn collision for logs back on
func _on_Character_animation_finished():
	if $Character.animation == "flash":
		$Character.play("straight")
		set_collision_mask_bit(2, true) # Turn on collsion for logs


func _on_Timer_timeout():
	moving = true
