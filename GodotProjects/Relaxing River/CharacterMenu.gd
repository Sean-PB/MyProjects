extends AnimatedSprite


var character_file = "user://character.txt"   # Declaring file to save character
var skin_r
var skin_g
var skin_b
var skin_a
var skin_color
var hair_r
var hair_g
var hair_b
var hair_a
var hair_color
var hair_length       # This will be 0 if short, 1 if long
var default_hair = Color(0, 0, 0, 1)
var default_skin = Color(0.74902, 0.560784, 0.403922, 1)

# Called when the node enters the scene tree for the first time.
func _ready():
	set_frame(0)
	#load_character()


#-------------------------------------------------------------------------------
# Loads character colors in from file to the character menu
#-------------------------------------------------------------------------------
# Check if there is a character file. If there is, read from it all the values
# and put them into variables. Then put those variables into their respective 
# character part color. Then set the character parts to those colors. Finally,
# set the correct hair length.
# If there is not a character file, set all values to default.
func load_character():
	var f = File.new()
	if f.file_exists(character_file):
		f.open(character_file, File.READ)
		var content = f.get_as_text()
		skin_r = float(content.split(",")[0])
		skin_g = float(content.split(",")[1])
		skin_b = float(content.split(",")[2])
		skin_a = float(content.split(",")[3])
		skin_color = Color(skin_r, skin_g, skin_b, skin_a)
		hair_r = float(content.split(",")[4])
		hair_g = float(content.split(",")[5])
		hair_b = float(content.split(",")[6])
		hair_a = float(content.split(",")[7])
		skin_color = Color(hair_r, hair_g, hair_b, hair_a)
		hair_length = int(content.split(",")[8])
		
		$Character.material.set("shader_param/NEWCOLOR", skin_color)
		$Skin.material.set("shader_param/NEWCOLOR", skin_color)
		$Character/LongHair.material.set("shader_param/NEWCOLOR", hair_color)
		$Character/ShortHair.material.set("shader_param/NEWCOLOR", hair_color)
		$Long.material.set("shader_param/NEWCOLOR", hair_color)
		$Short.material.set("shader_param/NEWCOLOR", hair_color)
		
		if int(hair_length):
			$Character/LongHair.show()
			$HairOutline.frame = 1
			$HairOutline.position = Vector2(238, -163)
		else:
			$Character/ShortHair.show()
			$HairOutline.frame = 0
			$HairOutline.position = Vector2(118, -173)
	else:
		$Character.material.set("shader_param/NEWCOLOR", default_skin)
		$Skin.material.set("shader_param/NEWCOLOR", default_skin)
		
		$Character/LongHair.material.set("shader_param/NEWCOLOR", default_hair)
		$Character/ShortHair.material.set("shader_param/NEWCOLOR", default_hair)
		$Long.material.set("shader_param/NEWCOLOR", default_hair)
		$Short.material.set("shader_param/NEWCOLOR", default_hair)
		$Character/ShortHair.show()
		$HairOutline.frame = 0
		$HairOutline.position = Vector2(118, -173)


#-------------------------------------------------------------------------------
# Saves player into the file.
#-------------------------------------------------------------------------------
func save_character():
	var f = File.new()
	f.open(character_file, File.WRITE)
	f.store_string((str(skin_color) + "/" + hair_color))
	f.close()


func _on_HairColor_color_changed(color):
	$Character/LongHair.material.set("shader_param/NEWCOLOR", color)
	$Character/ShortHair.material.set("shader_param/NEWCOLOR", color)
	$Long.material.set("shader_param/NEWCOLOR", color)
	$Short.material.set("shader_param/NEWCOLOR", color)
	hair_color = color
	


func _on_BodyColor_color_changed(color):
	$Character.material.set("shader_param/NEWCOLOR", color)
	$Skin.material.set("shader_param/NEWCOLOR", color)
	skin_color = color
	


func _on_Short_pressed():
	$Character/LongHair.hide()
	$Character/ShortHair.show()
	$HairOutline.frame = 0
	$HairOutline.position = Vector2(118, -173)


func _on_Long_pressed():
	$Character/ShortHair.hide()
	$Character/LongHair.show()
	$HairOutline.frame = 1
	$HairOutline.position = Vector2(238, -163)


func _on_Cancel_pressed():
	


func _on_Confirm_pressed():
	pass # Replace with function body.
