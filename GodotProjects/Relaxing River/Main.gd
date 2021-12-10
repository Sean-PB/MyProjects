extends Node2D


# ------------------------------------------------------------------------------
# Variables
# ------------------------------------------------------------------------------
const STRIP = preload("res://Strip.tscn")

var skin
var started
var playing
var straight_length
var challenge_mode
var river_top = 576
var rng = RandomNumberGenerator.new()


# ------------------------------------------------------------------------------
# Called when the node enters the scene tree for the first time.
# ------------------------------------------------------------------------------
func _ready():
	started = false
	
	# Loading world
	while river_top != -64:
		var strip = STRIP.instance()
		strip.position.y = river_top
		$World.add_child(strip)
		river_top -= 64
	
	# Loading character
	$Player.load_character()
	
	# Connecting signals for Character Selection and Settings menus
	$Camera2D/CharacterSelection.connect("character_exited", self, "exit_CharacterSelector")
	$Camera2D/SettingsMenu.connect("settings_exited", self, "exit_Settings")
	$Camera2D/SettingsMenu.connect("settings_confirmed", self, "confrim_settings")
	
	# Setting random length of straiht river section
	rng.randomize()                 # Randomize rng
	straight_length = rng.randi_range(1, 1) # set straight_length to new random number
	


# ------------------------------------------------------------------------------
# Called every frame. 'delta' is the elapsed time since the previous frame.
# ------------------------------------------------------------------------------
func _process(delta):
	$Player.playing = playing
	if started and not playing:
		# Move player away from doc
		$Player.leave_dock(delta)
		if $Player.position.y < 475:
			playing = true
		
	if playing == true:
		$Camera2D/Pause.show()
		$Camera2D.position.y = $Player.position.y
		spawn_world()


# ------------------------------------------------------------------------------
# Starts game
# ------------------------------------------------------------------------------
func _on_Start_released():
	# Show things
	$Player.show()
	$Camera2D/Start.hide()
	$Camera2D/EditCharacter.hide()
	$Camera2D/Blur.hide()
	$Camera2D/Settings.hide()
	$Camera2D/Settings.position.x = -64
	started = true
	# Play music (CHANGE TO BE RANDOM SONG ORDER LATER) !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	$Music.play()
	AudioServer.set_bus_mute(0, not $Camera2D/SettingsMenu.sound) # Whether to start muted or not


# ------------------------------------------------------------------------------
# Pauses game
# ------------------------------------------------------------------------------
func _on_Pause_released():
	playing = false
	get_tree().paused = true
	$Camera2D/Pause.hide()
	$Camera2D/Play.show()
	$Camera2D/EditCharacter.show()
	$Camera2D/Blur.show()
	$Camera2D/Settings.show()


# ------------------------------------------------------------------------------
# Unpauses game
# ------------------------------------------------------------------------------
func _on_Play_released():
	playing = true
	get_tree().paused = false
	$Camera2D/Pause.show()
	$Camera2D/Play.hide()
	$Camera2D/CharacterSelection.hide()
	$Camera2D/CharacterSelection._on_Exit_released()
	$Camera2D/SettingsMenu.hide()
	$Camera2D/SettingsMenu._on_Cancel_released()
	$Camera2D/EditCharacter.hide()
	$Camera2D/Blur.hide()
	$Camera2D/Settings.hide()


# ------------------------------------------------------------------------------
# This brings up the Character Selection menu
# ------------------------------------------------------------------------------
# This function hides the button that brought it up, brings up the edit 
# character menu, and closes the settings menu without saving it if its open.
func _on_EditCharacter_released():
	$Camera2D/Start.hide()
	$Camera2D/EditCharacter.hide()
	$Camera2D/CharacterSelection.show()
	if $Camera2D/SettingsMenu.visible:
		$Camera2D/SettingsMenu._on_Cancel_released()


# ------------------------------------------------------------------------------
# Closes Character Section menu when player confims or cancels changes
# ------------------------------------------------------------------------------
# This function is called from a signal emmited by the CharacterSelection scene.
# The function which sends this signal hides the Character Selector itself so 
# all this needs to do is unhide the button that brings the Character Selector
# up.
func exit_CharacterSelector():
	$Camera2D/EditCharacter.show()
	if not started:
		$Camera2D/Start.show()


# ------------------------------------------------------------------------------
# This brings up the settings menu
# ------------------------------------------------------------------------------
# This function hides the button that brought it up, brings up the edit settings
# menu, and closes the edit character menu without saving it if its open.
func _on_Settings_released():
	$Camera2D/Start.hide()
	$Camera2D/Settings.hide()
	$Camera2D/SettingsMenu.show()
	if $Camera2D/CharacterSelection.visible:
		$Camera2D/CharacterSelection._on_Exit_released()


# ------------------------------------------------------------------------------
# Closes Settings menu when the player confirms or cancels changes
# ------------------------------------------------------------------------------
# This function is called from a signal emmited by the SettingsMenu scene.
# The function which sends this signal hides the Settings menu itself so 
# all this needs to do is unhide the button that brings the Character Selector
# up.
func exit_Settings():
	$Camera2D/Settings.show()
	if not started:
		$Camera2D/Start.show()


# ------------------------------------------------------------------------------
# Applies settings changes made by player after confimation
# ------------------------------------------------------------------------------
func confrim_settings():
	AudioServer.set_bus_mute(0, not $Camera2D/SettingsMenu.sound)
	challenge_mode = $Camera2D/SettingsMenu.death


# ------------------------------------------------------------------------------
# This function spawns in the world one strip at a time.
# ------------------------------------------------------------------------------
# Whenever the player has moved up 1 strip length (64), we mark down the new 
# most recent player position benchmark to check against in the future then 
# create a new instance of the world strip. Then we take the position of the 
# most recent strip addition, move it up by 64, and place the new strip 
# instance there.
func spawn_world():
	# If were at a position to spawn something new
	if $Player.position.y - 576 <= river_top:
		# Decide what to spawn (bend or straight)
		if straight_length > 0:    # Straight
			var strip = STRIP.instance()
			strip.position.y = river_top
			$World.add_child(strip)
			river_top -= 64                # Adjust top of river position


# ------------------------------------------------------------------------------
# De-spawns dock when off screen
# ------------------------------------------------------------------------------
func _on_VisibilityNotifier2D_screen_exited():
	$Dock.queue_free()


# ------------------------------------------------------------------------------
# Maybe I can use this to make the 3 random order songs follow each other.
# ------------------------------------------------------------------------------
func _on_Music_finished():
	pass # Replace with function body.
