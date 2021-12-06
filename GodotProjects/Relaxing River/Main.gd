extends Node2D

const STRIP = preload("res://Strip.tscn")

var skin
var started
var playing
var last_player_pos = 950
var last_strip_pos = -384
var count = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.load_character()
	started = false
	
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
		spawn_world()
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
func spawn_world():
	if last_player_pos - $Player.position.y >= 128:
		last_player_pos -= 128
		var strip = STRIP.instance()
		last_strip_pos -= 128
		strip.position.y = last_strip_pos
		$Strips.add_child(strip)
		
		# CHANGE LATER!!!!!!!!!!!!!!!!!!
		# I can use different logic to make river splits using different
		# kinds of strips at different x coordinates.
		if count % 2 == 1:
			strip.position.x = -768
		else:
			strip.position.x = 0
		count += 1
