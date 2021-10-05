extends CanvasLayer

var skin = "middle"           # middle by default
var hair = "bald"             # bald by default
var character_file = "user://character.txt"   # Declaring file to save character
var started = false


func _ready():
	$Pause.hide()
	$Resume.hide()
	$CharacterSelectContainer.hide()


func _on_Start_pressed():        # Start button pressed
	started = true
	$Start.hide()
	$CharacterSelector.hide()
	$Message.hide()
	$Pause.show()
	get_parent().get_node("Player").started = true


func _on_Pause_pressed():     # Pause bitton pressed
	get_tree().paused = true        # Pause all of game
	get_parent().get_node("Player").hide()
	$Pause.hide()                   # Hide the pause button
	$Resume.show()                  # Show the resume button
	$CharacterSelector.show()       # Show character selector button
	$Message.text = "PAUSED"
	$Message.show()


func _on_Resume_pressed():      # Resume button pressed
	get_tree().paused = false       # Resume all of game
	get_parent().get_node("Player").show()
	$Pause.show()                   # Show the pause button
	$Resume.hide()                  # Hide the resume button
	$CharacterSelector.hide()       # Hide character selecetor button
	$Message.hide()


func save_character():             # To save character in a file
	var f = File.new()
	f.open(character_file, File.WRITE)
	f.store_string((skin + "/" + hair ))
	f.close()


# Character selector !!!!!!!!!!!!!!!!!!!! Maybe delete !!!!!!!!!!!!!!!!!!!
func _on_CharacterSelector_pressed():      # Character selector button pressed
	$CharacterSelector.hide()                  # Hide button
	$CharacterSelectContainer.show()           # Show skin options
	$Resume.hide()                             # Hide resume until done


func _on_DarkBlack_pressed():
	skin = "dark_black"
	$CharacterSelectContainer.hide()
	$CharacterSelector.show()                  # Show button
	if started == true:
		$Resume.show()                             # Show resume when done


func _on_LightBlack_pressed():
	skin = "light_black"
	$CharacterSelectContainer.hide()
	$CharacterSelector.show()                  # Show button
	if started == true:
		$Resume.show()                             # Show resume when done


func _on_Middle_pressed():
	skin = "middle"
	$CharacterSelectContainer.hide()
	$CharacterSelector.show()                  # Show button
	if started == true:
		$Resume.show()                             # Show resume when done


func _on_DarkWhite_pressed():
	skin = "dark_white"
	$CharacterSelectContainer.hide()
	$CharacterSelector.show()                  # Show button
	if started == true:
		$Resume.show()                             # Show resume when done


func _on_LightWhite_pressed():
	skin = "light_white"
	$CharacterSelectContainer.hide()
	$CharacterSelector.show()                  # Show button
	if started == true:
		$Resume.show()                             # Show resume when done

