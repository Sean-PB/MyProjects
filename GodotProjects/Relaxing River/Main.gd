extends Node2D

const STRIP = preload("res://Strip.tscn")
const BEND = preload("res://Bend.tscn")

var skin
var started
var playing
var straight_length
#var strip_count = 0
var river_top = -128
var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.load_character()
	started = false
	
	# Setting random length of straiht river section
	rng.randomize()                 # Randomize rng
	straight_length = rng.randi_range(0, 1) # set straight_length to new random number
	
	# Getting signal of when character editing is finished
	var CharacterDone = get_tree().get_root().find_node("CharacterSelection", true, false)
	CharacterDone.connect("exited", self, "exit_CharacterSelector")
	skin 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Player.playing = playing
	
	if started and not playing:
		# Move player away from doc
		$Player.leave_dock(delta)
		if $Player.position.y < 950:
			playing = true
			$Camera2D.current = true
		
	if playing == true:
		$Camera2D/Pause.show()
		$Camera2D.position.y = $Player.position.y
		spawn_world(delta)
		if $Player.position.y == 700:
			$Dock.queue_free()



func _on_Start_released():
	# Show things
	$Player.show()
	$Start.hide()
	$Camera2D/EditCharacter.hide()
	started = true


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
# Whenever the player has moved up 1 strip length (128), we mark down the new 
# most recent player position benchmark to check against in the future then 
# create a new instance of the world strip. Then we take the position of the 
# most recent strip addition, move it up by 128, and place the new strip 
# instance there.
func spawn_world(delta):
	#print("Player pos: " + str($Player.position.y))
	#print("River top: " + str(river_top))
	# If were at a position to spawn something new
	if $Player.position.y - 1280 <= river_top:
		# Decide what to spawn (bend or straight)
#		if straight_length > 0:    # Straight
			var strip = STRIP.instance()    # New strip instance
			strip.position.y = river_top    # Move strip to correct positoin
			$World.add_child(strip)         # Spawn strip into world
			river_top -= 128                # Adjust top of river position
#			straight_length -= 1            # keep track of how many straight strips left before bend
			
#		elif straight_length == 0:  # Bend
#			var bend = BEND.instance()      # New bend instance
#			bend.position.y = river_top     # Move bend to correct position
#			$World.add_child(bend)         # Spawn bend into world
#			bend.connect("left", self, "turn_left", [delta])
#			bend.connect("right", self, "turn_right", [delta])

#func turn_right(delta):
#	print("right")
#	$Camera2D.rotation_degrees += 90


#func turn_left(delta):
#	print("left")
#	$Camera2D.rotation_degrees -= 90
