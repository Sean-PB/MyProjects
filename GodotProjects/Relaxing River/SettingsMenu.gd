extends AnimatedSprite


signal confirmed
signal exited


# ------------------------------------------------------------------------------
# Variables
# ------------------------------------------------------------------------------
var file = "user://settings.txt"   # Declaring file to save settings and score
var sound
var death
var swipe
var speed


# Called when the node enters the scene tree for the first time.
func _ready():
	load_settings()
	set_frame(0)


# ------------------------------------------------------------------------------
# This loads in all the current settings to the menu so the player can see
# ------------------------------------------------------------------------------
func load_settings():
	var f = File.new()
	if f.file_exists(file):
		print("exisits")
		f.open(file, File.READ)
		var content = f.get_as_text()
		sound = content.split("/")[0]
		death = content.split("/")[1]
		swipe = content.split("/")[2]
		speed = content.split("/")[3]
		f.close()
		
		if bool(sound):
			$Unmute/Outline.show()
			$Mute/Outline.hide()
		else:
			$Mute/Outline.show()
			$Unmute/Outline.hide()
		
		if bool(death):
			$Death/Outline.show()
			$Invincible/Outline.hide()
		else:
			$Invincible/Outline.show()
			$Death/Outline.hide()
		
		
	else:
		print("doesn't exist")
		$Unmute/Outline.show()
		$Invincible/Outline.show()


# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
func save_settings(new_sound, new_death, new_swipe, new_speed):
	var f = File.new()
	f.open(file, File.WRITE)
	f.store_string((str(new_sound) + "/" + str(new_death) + "/" + str(new_swipe) + "/" + str(new_speed)))
	f.close()


# ------------------------------------------------------------------------------
# Cancels any changes the player has made to the settings
# ------------------------------------------------------------------------------
# It emits the signal exited for the Main scene and then resets the settings
# menu and sliders before hiding itself.
func _on_Cancel_released():
	emit_signal("exited")
	$Confirm.hide()
	set_frame(0)
	load_settings()
	hide()


# ------------------------------------------------------------------------------
# Confirms the changes the player made to the settings
# ------------------------------------------------------------------------------
# It emits the signal confirmed to signal that the Main scene should change its
# settings then it saves the settings to the file, emits the signal "exited" to
# the main scene, and hides itself.
func _on_Confirm_released():
	emit_signal("confirmed")
	save_settings(sound, death, swipe, speed)
	$Confirm.hide()
	set_frame(0)
	emit_signal("exited")
	hide()


# ------------------------------------------------------------------------------
# Turns mute on and highlights current selection
# ------------------------------------------------------------------------------
func _on_Mute_released():
	$Mute/Outline.show()
	$Unmute/Outline.hide()
	sound = false
	$Confirm.show()
	set_frame(1)


# ------------------------------------------------------------------------------
# Turns sound on and highlights current selection
# ------------------------------------------------------------------------------
func _on_Unmute_released():
	$Unmute/Outline.show()
	$Mute/Outline.hide()
	sound = true
	$Confirm.show()
	set_frame(1)


# ------------------------------------------------------------------------------
# Turns invincibility on and highlights current selection
# ------------------------------------------------------------------------------
func _on_Invincible_released():
	$Invincible/Outline.show()
	$Death/Outline.hide()
	death = false
	$Confirm.show()
	set_frame(1)


# ------------------------------------------------------------------------------
# Turns death mode on and highlights current selection
# ------------------------------------------------------------------------------
func _on_Death_released():
	$Death/Outline.show()
	$Invincible/Outline.hide()
	death = true
	$Confirm.show()
	set_frame(1)