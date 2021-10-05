extends Node2D


var skin
var started
var playing


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
	if started and not playing:
		# Move player away from doc
		$Player.leave_dock(delta)
		if $Player.position.y < 950:
			playing = true
		
	if playing == true:
		$Pause.show()
		
		# Allow player to use controls
		$Player.move(delta)



func _on_Start_released():
	# Show things
	$Player.show()
	$Start.hide()
	$EditCharacter.hide()
	started = true


func _on_Pause_released():
	playing = false
	get_tree().paused = true
	$Pause.hide()
	$Play.show()
	$EditCharacter.show()
	


func _on_Play_released():
	playing = true
	get_tree().paused = false
	$Pause.show()
	$Play.hide()
	$CharacterSelection.hide()
	$EditCharacter.hide()


func _on_EditCharacter_released():
	$EditCharacter.hide()
	$CharacterSelection.show()


func exit_CharacterSelector():
	$EditCharacter.show()
