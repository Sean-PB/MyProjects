extends Node2D


# ------------------------------------------------------------------------------
# Variables
# ------------------------------------------------------------------------------
const STRIP = preload("res://Strip.tscn")
const LOG = preload("res://Log.tscn")
const TREE = preload("res://Tree.tscn")

var skin
var started
var playing
var straight_length
var log_dist            # The RNG distance from the last log to the next
var challenge_mode
var old_log_x = 150     # The RNG x-axis of each log. Always at least half the 
						# logs length to the side of the previous log. 150 for
						# roughly middle of the screen during first spawning.
var river_top = 576
var rng = RandomNumberGenerator.new()


# ------------------------------------------------------------------------------
# Called when the node enters the scene tree for the first time.
# ------------------------------------------------------------------------------
func _ready():
	started = false
	rng.randomize()                 # Randomize rng
	
	# Loading world
	while river_top != -64:
		# River
		var strip = STRIP.instance()
		strip.position.y = river_top
		$World.add_child(strip)
		river_top -= 64
		
		# Tree
		if rng.randi_range(0, 1):  # Left
			var tree_left = TREE.instance()
			tree_left.position.x = rng.randi_range(-10, 35)
			tree_left.position.y = rng.randi_range(strip.position.y + 4, strip.position.y + 60)
			$Trees.add_child(tree_left)
		if rng.randi_range(0, 1):  # Rigth
			var tree_right = TREE.instance()
			tree_right.position.x = rng.randi_range(345, 395)
			tree_right.position.y = rng.randi_range(strip.position.y + 4, strip.position.y + 60)
			$Trees.add_child(tree_right)
	
	log_dist = 0             # Setting log_dist to 0 so theres a log immediately
	
	# Loading character
	$Player.load_character()
	
	# Connecting signals for Character Selection and Settings menus
	$Camera2D/CharacterSelection.connect("character_exited", self, "exit_CharacterSelector")
	$Camera2D/SettingsMenu.connect("settings_exited", self, "exit_Settings")
	$Camera2D/SettingsMenu.connect("settings_confirmed", self, "confrim_settings")
	
	# Setting random length of straiht river section
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
func _on_Start_pressed():
	# Show things
	$Camera2D/Start.hide()
	$Camera2D/EditCharacter.hide()
	$Camera2D/Blur.hide()
	$Camera2D/Settings.hide()
	$Camera2D/Settings.rect_position = Vector2(-64, -840)
	started = true
	# Play music (CHANGE TO BE RANDOM SONG ORDER LATER) !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	$Music.play()
	AudioServer.set_bus_mute(0, not $Camera2D/SettingsMenu.sound) # Whether to start muted or not


# ------------------------------------------------------------------------------
# Pauses game
# ------------------------------------------------------------------------------
func _on_Pause_pressed():
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
func _on_Play_pressed():
	playing = true
	get_tree().paused = false
	$Camera2D/Pause.show()
	$Camera2D/Play.hide()
	$Camera2D/CharacterSelection.hide()
	$Camera2D/CharacterSelection._on_Exit_pressed()
	$Camera2D/SettingsMenu.hide()
	$Camera2D/SettingsMenu._on_Cancel_pressed()
	$Camera2D/EditCharacter.hide()
	$Camera2D/Blur.hide()
	$Camera2D/Settings.hide()


# ------------------------------------------------------------------------------
# This brings up the Character Selection menu
# ------------------------------------------------------------------------------
# This function hides the button that brought it up, brings up the edit 
# character menu, and closes the settings menu without saving it if its open.
func _on_EditCharacter_pressed():
	$Camera2D/Start.hide()
	$Camera2D/EditCharacter.hide()
	$Camera2D/CharacterSelection.show()
	if $Camera2D/SettingsMenu.visible:
		$Camera2D/SettingsMenu._on_Cancel_pressed()


# ------------------------------------------------------------------------------
# Closes Character Section menu when player confims or cancels changes
# ------------------------------------------------------------------------------
# This function is called from a signal emmited by the CharacterSelection scene.
# The function which sends this signal hides the Character Selector itself so 
# all this needs to do is unhide the button that brings the Character Selector
# up.
func exit_CharacterSelector():
	$Camera2D/EditCharacter.show()
	if not started and $Camera2D/SettingsMenu.visible == false:
		$Camera2D/Start.show()


# ------------------------------------------------------------------------------
# This brings up the settings menu
# ------------------------------------------------------------------------------
# This function hides the button that brought it up, brings up the edit settings
# menu, and closes the edit character menu without saving it if its open.
func _on_Settings_pressed():
	$Camera2D/Start.hide()
	$Camera2D/Settings.hide()
	$Camera2D/SettingsMenu.show()
	if $Camera2D/CharacterSelection.visible:
		$Camera2D/CharacterSelection._on_Exit_pressed()


# ------------------------------------------------------------------------------
# Closes Settings menu when the player confirms or cancels changes
# ------------------------------------------------------------------------------
# This function is called from a signal emmited by the SettingsMenu scene.
# The function which sends this signal hides the Settings menu itself so 
# all this needs to do is unhide the button that brings the Character Selector
# up.
func exit_Settings():
	$Camera2D/Settings.show()
	if not started and $Camera2D/CharacterSelection.visible == false:
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
# River:
# Whenever the player has moved up 1 strip length (64), we mark down the new 
# most recent player position benchmark to check against in the future then 
# create a new instance of the world strip. Then we take the position of the 
# most recent strip addition, move it up by 64, and place the new strip 
# instance there.
# Log:
# Check to see if its time for a new log with log_dist. If so, make a new 
# instance of the Log scene, randomize rng, set the new log's position to be 
# somewhere far enough away from the previous log, spawn the log, at the rnadom
# x position and the y position of the new river strip, then record the position
# of the log for later. Finally, randomly choose the next amount of strips away
# for the next log to be. If it is not time for a new log, decrement log_dist.
# Tree: 
# If the tree distance isn't at 0 yet, decrement tree_dist. If it is, choose a 
# random x and y position for it within the bounds of the grass and spawn it. 
# Then, reset the random distance until the next tree.
func spawn_world():
	# If were at a position to spawn something new
	if $Player.position.y - 576 <= river_top:
		# Decide what to spawn (bend or straight)
		if straight_length > 0:    # Straight
			rng.randomize()
			
			# River
			var strip = STRIP.instance()
			strip.position.y = river_top
			$World.add_child(strip)
			river_top -= 64                # Adjust top of river position
			
			# Log
			if log_dist == 0:
				var new_log = LOG.instance()
				new_log.position.x = rng.randi_range(100, 285)
				# Chose a random number until its far enough away from the previous log
				while new_log.position.x >= old_log_x - 20 and new_log.position.x <= old_log_x + 20:
					new_log.position.x = rng.randi_range(100, 285)
				new_log.position.y = strip.position.y + 30
				$World.add_child(new_log)
				old_log_x = new_log.position.x
				log_dist = rng.randi_range(1, 4)
			else:
				log_dist -= 1
			
			# Tree
			if rng.randi_range(0, 1):  # Left
				var tree_left = TREE.instance()
				tree_left.position.x = rng.randi_range(-10, 35)
				tree_left.position.y = rng.randi_range(strip.position.y + 4, strip.position.y + 60)
				$Trees.add_child(tree_left)
				
			if rng.randi_range(0, 1):  # Right
				var tree_right = TREE.instance()
				tree_right.position.x = rng.randi_range(345, 395)
				tree_right.position.y = rng.randi_range(strip.position.y + 4, strip.position.y + 60)
				$Trees.add_child(tree_right)
			
			# Bird
			#if rng.randi_range(1, 20) == 1:
				# Make the birds position the same as the tree's that was just spawned


# ------------------------------------------------------------------------------
# De-spawns dock when off screen
# ------------------------------------------------------------------------------
func _on_VisibilityNotifier2D_screen_exited():
	$Dock.queue_free()


# ------------------------------------------------------------------------------
# Maybe I can use this to make the 3 random order songs follow each other.
# ------------------------------------------------------------------------------
func _on_Music_finished():
	pass
