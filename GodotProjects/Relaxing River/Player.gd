extends KinematicBody2D

var started = false                        # Has the game started
var velocity = Vector2(0, -15)             # velocity variable
var skin
var hair
var character_file = "user://character.txt"   # Declaring file to save character

func _ready():
	$Skin.hide()
	position = Vector2(90, 250)                  # Set player position on screen

func _process(delta):
	if started:
		load_character()
		$Skin.show()
		# Movement
		velocity = move_and_slide(velocity)         # Move player up river
		
		if $SwipeControls.swipe_direction > 0:      # Swipe right
			rotation_degrees += 15 * delta          # Rotate player
			$Skin.change_animation(skin, "right")
		elif $SwipeControls.swipe_direction < 0:  # Swipe left
			rotation_degrees -= 15 * delta          # Rotate player
			$Skin.change_animation(skin, "left")
		else:
			rotation_degrees += 0
			yield($Skin, "animation_finished")      # Wait until any other animmation is done before changing to straight
			$Skin.change_animation(skin, "straight")
		
		rotation_degrees = clamp(rotation_degrees, -30, 30)  # Restrict rotation
		
		# Direction based on rotation degrees
		if rotation_degrees < 0:
			velocity.x += (rotation_degrees / 3) * delta
		elif rotation_degrees > 0:
			velocity.x += (rotation_degrees / 3) * delta
		else:
			velocity.x += 0

func load_character():
	var f = File.new()
	if f.file_exists(character_file):
		f.open(character_file, File.READ)
		var content = f.get_as_text()
		skin = content.split("/")[0]
		hair = content.split("/")[1]
		f.close()
