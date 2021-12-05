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

