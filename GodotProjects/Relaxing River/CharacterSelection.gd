extends AnimatedSprite


signal character_confirmed
signal character_exited


var character_file = "user://character.txt"   # Declaring file to save character
var skin
var hair


# Called when the node enters the scene tree for the first time.
func _ready():
	set_frame(0)
	load_character()


func load_character():
	var f = File.new()
	if f.file_exists(character_file):
		f.open(character_file, File.READ)
		var content = f.get_as_text()
		skin = content.split("/")[0]
		hair = content.split("/")[1]
		f.close()
		$Skin.frame = int(skin)
		$Hair.show()
		if hair == "bald":
			$Hair.hide()
		elif hair == "black":
			$Hair.frame = 0
		elif hair == "brown":
			$Hair.frame = 1
		elif hair == "blonde":
			$Hair.frame = 2
		elif hair == "red":
			$Hair.frame = 3
	else:
		$Skin.frame = 3
		$Hair.hide()


func save_character(skin_color, hair_color):
	var f = File.new()
	f.open(character_file, File.WRITE)
	f.store_string((str(skin_color) + "/" + hair_color))
	f.close()


func _on_1_released():
	skin = 1
	$Skin.frame = 0
	$Confirm.show()
	set_frame(1)


func _on_2_released():
	skin = 2
	$Skin.frame = 1
	$Confirm.show()
	set_frame(1)


func _on_3_released():
	skin = 3
	$Skin.frame = 2
	$Confirm.show()
	set_frame(1)


func _on_4_released():
	skin = 4
	$Skin.frame = 3
	$Confirm.show()
	set_frame(1)


func _on_5_released():
	skin = 5
	$Skin.frame = 4
	$Confirm.show()
	set_frame(1)


func _on_Black_released():
	hair = "black"
	$Hair.show()
	$Hair.frame = 0
	$Confirm.show()
	set_frame(1)


func _on_Brown_released():
	hair = "brown"
	$Hair.show()
	$Hair.frame = 1
	$Confirm.show()
	set_frame(1)


func _on_Blonde_released():
	hair = "blonde"
	$Hair.show()
	$Hair.frame = 2
	$Confirm.show()
	set_frame(1)


func _on_Red_released():
	hair = "red"
	$Hair.show()
	$Hair.frame = 3
	$Confirm.show()
	set_frame(1)


func _on_Bald_released():
	hair = "bald"
	$Hair.hide()
	$Confirm.show()
	set_frame(1)


func _on_Confirm_released():
	save_character(skin, hair)
	emit_signal("character_confirmed")
	$Confirm.hide()
	set_frame(0)
	emit_signal("character_exited")
	hide()


func _on_Exit_released():
	emit_signal("character_exited")
	$Confirm.hide()
	set_frame(0)
	load_character()
	hide()
