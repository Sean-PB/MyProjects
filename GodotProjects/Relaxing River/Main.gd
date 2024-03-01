extends Node2D


# ------------------------------------------------------------------------------
# Variables
# ------------------------------------------------------------------------------
var high_score_file = "user://high_score.txt"   # Declaring file to save high score

const STRIP = preload("res://Strip.tscn")
const LOG = preload("res://Log.tscn")
const BIRD = preload("res://Bird.tscn")
const BERRY = preload("res://Berries.tscn")

var skin
var started
var straight_length
var log_dist            # The RNG distance from the last log to the next
var bird_dist
var berry_dist = 10
var challenge_mode
var old_log_x = 150     # The RNG x-axis of each log. Always at least half the 
						# logs length to the side of the previous log. 150 for
						# roughly middle of the screen during first spawning.
var river_top = 576
var rng = RandomNumberGenerator.new()
var songs = []
var current_song = 0


# ------------------------------------------------------------------------------
# Called when the node enters the scene tree for the first time.
# ------------------------------------------------------------------------------
func _ready():
	started = false
	rng.randomize()                 # Randomize rng
	
	# Loading world
	while river_top != -64:
		# River
		var strip = STRIP.instantiate()
		strip.position.y = river_top
		$World.add_child(strip)
		river_top -= 64
	
	log_dist = 0             # Setting log_dist to 0 so theres a log immediately
	bird_dist = rng.randi_range(10, 20) # Setting first bird_dist to be reletivley soon
	
	# Loading character
	$Player.load_character()
	
	# Load high score
	if FileAccess.file_exists(high_score_file):
		var file = FileAccess.open(high_score_file, FileAccess.READ)
		$Camera2D/HighScore.text = file.get_as_text()
	
	# Connecting signals for Character Selection and Settings menus
# warning-ignore:return_value_discarded
	$Camera2D/CharacterMenu.connect("character_exited", Callable(self, "exit_CharacterMenu"))
# warning-ignore:return_value_discarded
	$Camera2D/SettingsMenu.connect("settings_exited", Callable(self, "exit_Settings"))
# warning-ignore:return_value_discarded
	$Camera2D/SettingsMenu.connect("settings_confirmed", Callable(self, "confrim_settings"))
# warning-ignore:return_value_discarded
	$SplashScreen.connect("splash_done", Callable(self, "splash_done"))
# warning-ignore:return_value_discarded
	$Player.connect("crash", Callable(self, "crash"))
	$Player.connect("score", Callable(self, "increment_score"))
	
	# Setting random length of straiht river section
	straight_length = rng.randi_range(1, 1) # set straight_length to new random number
	
	# Randomizing song order and get first song ready
	songs.append("res://Art/Sound/song1.wav")
	songs.append("res://Art/Sound/song2.wav")
	songs.append("res://Art/Sound/song3.wav")
	songs.shuffle()
	$Music.stream = load(songs[current_song])


# ------------------------------------------------------------------------------
# Called every frame. 'delta' is the elapsed time since the previous frame.
# ------------------------------------------------------------------------------
func _process(_delta):
	spawn_world()

	if $Player.position.y <= 475:
		$Camera2D.position.y = $Player.position.y
	


# ------------------------------------------------------------------------------
# Starts game
# ------------------------------------------------------------------------------
func _on_Start_pressed():
	# Show things
	$Camera2D/Start.hide()
	$Camera2D/Pause.show()
	$Camera2D/EditCharacter.hide()
	$Camera2D/Blur.hide()
	$Camera2D/Settings.hide()
	$Camera2D/Score.show()
	$Camera2D/HighScore.hide()
	started = true
	$Music.play()
	$Music.stream_paused = not $Camera2D/SettingsMenu.sound
	challenge_mode = $Camera2D/SettingsMenu.challenge_mode # Whether challenge mode is on or not
	if challenge_mode:
		$Camera2D/Score.show()
	else:
		$Camera2D/Score.hide()
	$Player.leaving_dock = true # Telling the Player scene to leave the dock

# ------------------------------------------------------------------------------
# Pauses game
# ------------------------------------------------------------------------------
func _on_Pause_pressed():
	get_tree().paused = true
	$Camera2D/Pause.hide()
	$Camera2D/Play.show()
	$Camera2D/EditCharacter.show()
	$Camera2D/Blur.show()
	$Camera2D/Settings.show()
	$Camera2D/HighScore.show()


# ------------------------------------------------------------------------------
# Unpauses game
# ------------------------------------------------------------------------------
func _on_Play_pressed():
	get_tree().paused = false
	$Camera2D/Pause.show()
	$Camera2D/Play.hide()
	$Camera2D/CharacterMenu.hide()
	$Camera2D/CharacterMenu._on_Cancel_pressed()
	$Camera2D/SettingsMenu.hide()
	$Camera2D/SettingsMenu._on_Cancel_pressed()
	$Camera2D/EditCharacter.hide()
	$Camera2D/Blur.hide()
	$Camera2D/Settings.hide()
	$Camera2D/HighScore.hide()
	$Music.stream_paused = not $Camera2D/SettingsMenu.sound


# ------------------------------------------------------------------------------
# This brings up the Character Selection menu
# ------------------------------------------------------------------------------
# This function hides the button that brought it up, brings up the edit 
# character menu, and closes the settings menu without saving it if its open.
func _on_EditCharacter_pressed():
	$Camera2D/Start.hide()
	$Camera2D/EditCharacter.hide()
	$Camera2D/CharacterMenu.show()
	$Camera2D/Play.hide()
	if $Camera2D/SettingsMenu.visible:
		$Camera2D/SettingsMenu._on_Cancel_pressed()


# ------------------------------------------------------------------------------
# Closes Character Section menu when player confims or cancels changes
# ------------------------------------------------------------------------------
# This function is called from a signal emmited by the CharacterMenu scene.
# The function which sends this signal hides the Character Selector itself so 
# all this needs to do is unhide the button that brings the Character Selector
# up.
func exit_CharacterMenu():
	$Camera2D/EditCharacter.show()
	if get_tree().paused == true:
		$Camera2D/Play.show()
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
	$Camera2D/Play.hide()
	if $Camera2D/CharacterMenu.visible:
		$Camera2D/CharacterMenu._on_Cancel_pressed()


# ------------------------------------------------------------------------------
# Closes Settings menu when the player confirms or cancels changes
# ------------------------------------------------------------------------------
# This function is called from a signal emmited by the SettingsMenu scene.
# The function which sends this signal hides the Settings menu itself so 
# all this needs to do is unhide the button that brings the Character Selector
# up.
func exit_Settings():
	$Camera2D/Settings.show()
	if get_tree().paused == true:
		$Camera2D/Play.show()
	if not started and $Camera2D/CharacterMenu.visible == false:
		$Camera2D/Start.show()


# ------------------------------------------------------------------------------
# Applies settings changes made by player after confimation
# ------------------------------------------------------------------------------
func confrim_settings():
	challenge_mode = $Camera2D/SettingsMenu.challenge_mode
	if challenge_mode:
		$Camera2D/Score.show()
	else:
		$Camera2D/Score.hide()
	


# ------------------------------------------------------------------------------
# This function spawns in the world one strip at a time.
# ------------------------------------------------------------------------------
# See each section below for details
func spawn_world():
	# If were at a position to spawn something new
	if $Player.position.y - 576 <= river_top:
		# Decide what to spawn (bend or straight)
		if straight_length > 0:    # Straight
			rng.randomize()
			
			# River:
			# Whenever the player has moved up 1 strip length (64), we mark down
			# the new most recent player position benchmark to check against in
			# the future then create a new instance of the world strip. Then we
			# take the position of the most recent strip addition, move it up by
			# 64, and place the new strip instance there.
			var strip = STRIP.instantiate()
			strip.position.y = river_top
			$World.add_child(strip)
			river_top -= 64                # Adjust top of river position
			
			# Log or Berry:
			# Check to see if its time for a new log with log_dist. If so, make
			# a new instance of the Log scene, randomize rng, set the new log's
			# position to be somewhere far enough away from the previous log,
			# spawn the log, at the rnadom x position and the y position of the
			# new river strip, then record the position of the log for later.
			# Finally, randomly choose the next amount of strips away for the
			# next log to be. If it is not time for a new log, decrement
			# log_dist.
			if log_dist == 0:
				var new_log = LOG.instantiate()
				new_log.position.x = rng.randi_range(100, 285)
				# Chose a random number until its far enough away from the previous log
				while new_log.position.x >= old_log_x - 20 and new_log.position.x <= old_log_x + 20:
					new_log.position.x = rng.randi_range(100, 285)
				new_log.position.y = strip.position.y + 30
				$World.add_child(new_log)
				old_log_x = new_log.position.x
				log_dist = rng.randi_range(1, 2) # Choose new log dist
			else:
				log_dist -= 1
				berry_dist -= 1
				# Berry:
				if berry_dist <= 0:
					var new_berry = BERRY.instantiate()
					new_berry.position.x = rng.randi_range(100, 285)
					new_berry.position.y = strip.position.y + 30
					$World.add_child(new_berry)
					berry_dist = rng.randi_range(5, 10)
			
			# Bird
			# If it's not time for a bird, decrement from the counter.
			# If it is time for a bird, make an instance, set its position to one side, 
			if bird_dist == 0:
				var bird = BIRD.instantiate()
				var bird_x = rng.randi_range(1, 2)
				if bird_x == 1:
					bird.position.x = -10
					bird.rotation_degrees = randi_range(15, 105)
				else:
					bird.position.x = 600
					bird.rotation_degrees = randi_range(-15, -105)
				bird.position.y = $Player.position.y - randi_range(250, 650)
				$World.add_child(bird)
				bird_dist = rng.randi_range(30, 60)
			else:
				bird_dist -= 1


# ------------------------------------------------------------------------------
# When the player crashes into a log this function deals with changing the score
# ------------------------------------------------------------------------------
# Shake camera
# Save score if higher than high score
# Reset score
func crash():
	$Camera2D.shake(100, 0.5)
	if int($Camera2D/Score.text) > int($Camera2D/HighScore.text):
		var file = FileAccess.open(high_score_file, FileAccess.WRITE)
		file.store_string($Camera2D/Score.text)
		file.close()
		$Camera2D/HighScore.text = $Camera2D/Score.text
	$Camera2D/Score.text = str(0)
	$Camera2D/Score.modulate = Color("white")

# ------------------------------------------------------------------------------
# When the player gets a berry this function deals with changing the score
# ------------------------------------------------------------------------------
func increment_score():
	$Camera2D/Score.text = str(int($Camera2D/Score.text) + 1)
	if int($Camera2D/Score.text) > int($Camera2D/HighScore.text):
		$Camera2D/Score.modulate = Color("red")


# ------------------------------------------------------------------------------
# De-spawns dock when off screen
# ------------------------------------------------------------------------------
func _on_VisibilityNotifier2D_screen_exited():
	$Dock.queue_free()


# ------------------------------------------------------------------------------
# Maybe I can use this to make the 3 random order songs follow each other.
# ------------------------------------------------------------------------------
func _on_Music_finished():
	if (current_song == len(songs) - 1):
		current_song = 0
	else:
		current_song += 1
	
	$Music.stream = load(songs[current_song])
	$Music.play()
	$Music.stream_paused = not $Camera2D/SettingsMenu.sound


# ------------------------------------------------------------------------------
# Makes buttons acessable after splash screen is finished
# ------------------------------------------------------------------------------
func splash_done():
	$Camera2D/Start.show()
	$Camera2D/EditCharacter.show()
	$Camera2D/Settings.show()
