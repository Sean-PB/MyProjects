extends Node2D

const STRIP = preload("res://Strip.tscn")

var skin
var started
var playing
var straight_length
var river_top = 576
var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
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
	
	# Getting signal of when character editing is finished
	var CharacterDone = get_tree().get_root().find_node("CharacterSelection", true, false)
	CharacterDone.connect("exited", self, "exit_CharacterSelector")
	
	# Setting random length of straiht river section
	rng.randomize()                 # Randomize rng
	straight_length = rng.randi_range(1, 1) # set straight_length to new random number
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Player.playing = playing
	
	if started and not playing:
		# Move player away from doc
		$Player.leave_dock(delta)
		if $Player.position.y < 475:
			playing = true
			$Camera2D.current = true
		
	if playing == true:
		$Camera2D/Pause.show()
		$Camera2D.position.y = $Player.position.y
		spawn_world()



func _on_Start_released():
	# Show things
	$Player.show()
	$Start.hide()
	$Camera2D/EditCharacter.hide()
	started = true
	# Play music (CHANGE TO BE RANDOM SONG ORDER LATER) !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	$Music.play()


func _on_Pause_released():
	playing = false
	get_tree().paused = true
	$Camera2D/Pause.hide()
	$Camera2D/Play.show()
	$Camera2D/EditCharacter.show()
	


func _on_Play_released():
	playing = true
	get_tree().paused = false
	$Camera2D/Pause.show()
	$Camera2D/Play.hide()
	$Camera2D/CharacterSelection.hide()
	$Camera2D/EditCharacter.hide()


func _on_EditCharacter_released():
	$Camera2D/EditCharacter.hide()
	$Camera2D/CharacterSelection.show()


func exit_CharacterSelector():
	$Camera2D/EditCharacter.show()


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


# De-spawns dock when off screen
func _on_VisibilityNotifier2D_screen_exited():
	$Dock.queue_free()

# Maybe I can use this to make the 3 random order songs follow each other.
func _on_Music_finished():
	pass # Replace with function body.
