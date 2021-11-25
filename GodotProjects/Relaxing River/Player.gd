extends KinematicBody2D


var character_file = "user://character.txt"   # Declaring file to save character
var skin
var hair
var animation
var frame
var speed = 50
var velocity = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	var Selection = get_tree().get_root().find_node("CharacterSelection", true, false)
	Selection.connect("confirmed", self, "load_character")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func load_character():
	var f = File.new()
	if f.file_exists(character_file):
		f.open(character_file, File.READ)
		var content = f.get_as_text()
		skin = content.split("/")[0]
		hair = content.split("/")[1]
		f.close()
		
		animation = $Skin.animation
		frame = $Skin.frame
		animation.erase(animation.length() - 1, 1)
		animation += skin
		$Skin.animation = animation
		$Skin.frame = frame
		
		$Skin/Hair.show()
		if hair == "bald":
			$Skin/Hair.hide()
		elif hair == "black":
			$Skin/Hair.frame = 0
		elif hair == "brown":
			$Skin/Hair.frame = 1
		elif hair == "blonde":
			$Skin/Hair.frame = 2
		elif hair == "red":
			$Skin/Hair.frame = 3
	else:
		$Skin.frame = 3
		$Skin/Hair.hide()


func leave_dock(delta):
	if rotation_degrees > 45:		# Turning left
		$Skin.play("left" + skin)
		rotation_degrees -= 25 * delta
		velocity = move_and_slide(Vector2(0, -speed).rotated(rotation))
	elif rotation_degrees > 0:		# Turning left
		$Skin.play("straight" + skin)
		rotation_degrees -= 30 * delta
		velocity = move_and_slide(Vector2(0, -speed).rotated(rotation))
	elif position.y > 950:			# Moving into finished position
		velocity = move_and_slide(Vector2(0, -speed).rotated(rotation))


func move(delta):
	velocity = move_and_slide(Vector2(0, -speed).rotated(rotation))

