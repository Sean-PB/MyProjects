extends AnimatedSprite


signal character_confirmed
signal character_exited


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
	skin_color = default_skin
	hair_color = default_hair
	hair_length = 0
	set_frame(0)
	load_character()


#-------------------------------------------------------------------------------
# Loads character colors in from file to the character menu
#-------------------------------------------------------------------------------
# Check if there is a character file. If there is, read from it all the values
# and put them into variables. Then put those variables into their respective 
# character part color. Then set the character parts to those colors. Then, set
# the color picker buttons to their repective colors. Finally, set the correct hair 
# length.
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
		hair_color = Color(hair_r, hair_g, hair_b, hair_a)
		hair_length = int(content.split(",")[8])
		
		$Character.material.set("shader_param/NEWCOLOR", skin_color)
		$Skin.material.set("shader_param/NEWCOLOR", skin_color)
		$Character/Hair.material.set("shader_param/NEWCOLOR", hair_color)
		$Long.material.set("shader_param/NEWCOLOR", hair_color)
		$Short.material.set("shader_param/NEWCOLOR", hair_color)
		
		$HairColor.color = hair_color
		$BodyColor.color = skin_color
		
		if int(hair_length):
			$Character/Hair.frame = 1
			$Character/Hair.position.y = 7
			$HairOutline.frame = 1
			$HairOutline.position = Vector2(238, -163)
		else:
			$Character/Hair.frame = 0
			$Character/Hair.position.y = 6
			$HairOutline.frame = 0
			$HairOutline.position = Vector2(118, -173)
		
	else:
		$Character.material.set("shader_param/NEWCOLOR", default_skin)
		$Skin.material.set("shader_param/NEWCOLOR", default_skin)
		
		$Character/Hair.material.set("shader_param/NEWCOLOR", default_hair)
		$Character/Hair.frame = 0
		$Character/Hair.position.y = 6
		$Long.material.set("shader_param/NEWCOLOR", default_hair)
		$Short.material.set("shader_param/NEWCOLOR", default_hair)
		$HairOutline.frame = 0
		$HairOutline.position = Vector2(118, -173)
		
		$HairColor.color = default_hair
		$BodyColor.color = default_skin


#-------------------------------------------------------------------------------
# Saves player into the file.
#-------------------------------------------------------------------------------
# Open, write, and close the file
func save_character():
	var f = File.new()
	f.open(character_file, File.WRITE)
	f.store_string(str(skin_color) + "," + str(hair_color) + "," + str(hair_length))
	f.close()


#-------------------------------------------------------------------------------
# Whenever the "HairColor" color picker button is changed
#-------------------------------------------------------------------------------
# Change the hair colors of long and short hair for the character demo and the
# long and short hair buttons. Then save the color into the hair_color variable.
# Finally, show the confirm button
func _on_HairColor_color_changed(color):
	$Character/Hair.material.set("shader_param/NEWCOLOR", color)
	$Long.material.set("shader_param/NEWCOLOR", color)
	$Short.material.set("shader_param/NEWCOLOR", color)
	hair_color = color
	$Confirm.show()
	set_frame(1)
	


#-------------------------------------------------------------------------------
# Whenever the "BodyColor" color picker button is changed
#-------------------------------------------------------------------------------
# Change the body color of the character demo and skin symbol. Finally, show the
# confirm button
func _on_BodyColor_color_changed(color):
	$Character.material.set("shader_param/NEWCOLOR", color)
	$Skin.material.set("shader_param/NEWCOLOR", color)
	skin_color = color
	$Confirm.show()
	set_frame(1)
	


#-------------------------------------------------------------------------------
# Changes hair length to short hair
#-------------------------------------------------------------------------------
# If not already selected, switch the long and short hair on the character demo
# then move the outline to show which length is selected. Finally, show the
# confirm button.
func _on_Short_pressed():
	if $Character/Hair.frame == 1:
		$Character/Hair.frame = 0
		$Character/Hair.position.y = 6
		$HairOutline.frame = 0
		$HairOutline.position = Vector2(118, -173)
		hair_length = 0
		$Confirm.show()
		set_frame(1)


#-------------------------------------------------------------------------------
# Changes hair length to long hair
#-------------------------------------------------------------------------------
# If not already selected, switch the long and short hair on the character demo
# then move the outline to show which length is selected. Finally, show the
# confirm button.
func _on_Long_pressed():
	if $Character/Hair.frame == 0:
		$Character/Hair.frame = 1
		$Character/Hair.position.y = 7
		$HairOutline.frame = 1
		$HairOutline.position = Vector2(238, -163)
		hair_length = 1
		$Confirm.show()
		set_frame(1)


#-------------------------------------------------------------------------------
# Cancel the changes made to character
#-------------------------------------------------------------------------------
# Emit signal to let outer scene know player is done editing character. Resest
# all the changes made including the confirm button being visible then hide.
func _on_Cancel_pressed():
	emit_signal("character_exited")
	$Confirm.hide()
	set_frame(0)
	load_character()
	hide()


#-------------------------------------------------------------------------------
# Confirm the changes made to character
#-------------------------------------------------------------------------------
# Save the character to the file, let outer scene know player has changed the 
# appearance of the character, reset background, let outside scene know the 
# player is done editing the character, then hide menu.
func _on_Confirm_pressed():
	save_character()
	emit_signal("character_confirmed")
	$Confirm.hide()
	set_frame(0)
	emit_signal("character_exited")
	hide()


func _on_HairColor_pressed():
	print($HairColor.get_picker().rect_position)
	$HairColor.add_child($HairColor.get_picker())
