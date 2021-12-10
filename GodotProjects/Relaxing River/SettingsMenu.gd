extends AnimatedSprite


signal settings_confirmed
signal settings_exited


# ------------------------------------------------------------------------------
# Variables
# ------------------------------------------------------------------------------
var file = "user://settings.txt"   # Declaring file to save settings and score
var sound
var death
# This var is to make sure that the initial change for speed and swipe doesn't 
# cause the confirm button to show.
var initial_change = true


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
		f.open(file, File.READ)
		var content = f.get_as_text()
		sound = int(content.split("/")[0])
		death = int(content.split("/")[1])
		$Swipe.value = int(content.split("/")[2])
		$Speed.value = int(content.split("/")[3])
		initial_change = false # has to be changed below the speed and swipe changes
		f.close()
		
		if sound:
			$Sound/Outline.show()
			$Mute/Outline.hide()
		else:
			$Mute/Outline.show()
			$Sound/Outline.hide()
		
		if death:
			$Death/Outline.show()
			$Invincible/Outline.hide()
		else:
			$Invincible/Outline.show()
			$Death/Outline.hide()
		
	else:
		sound = true
		$Sound/Outline.show()
		death = false
		$Invincible/Outline.show()
		$Speed.value = 40
		$Swipe.value = 15
		initial_change = false # has to be changed below the speed and swipe changes


# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
func save_settings(new_sound, new_death, new_swipe, new_speed):
	var f = File.new()
	f.open(file, File.WRITE)
	f.store_string((str(new_sound) + "/" + str(new_death) + "/" + str(new_swipe)
		 + "/" + str(new_speed)))
	f.close()


# ------------------------------------------------------------------------------
# Cancels any changes the player has made to the settings
# ------------------------------------------------------------------------------
# It emits the signal exited for the Main scene and then resets the settings
# menu and sliders before hiding itself.
func _on_Cancel_released():
	emit_signal("settings_exited")
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
	emit_signal("settings_confirmed")
	save_settings(sound, death, $Swipe.value, $Speed.value)
	$Confirm.hide()
	set_frame(0)
	emit_signal("settings_exited")
	hide()


# ------------------------------------------------------------------------------
# Turns mute on and highlights current selection
# ------------------------------------------------------------------------------
# The check to see if the outline is visible has to before its made visible to 
# actually check. The check is there because I don't want the confirm button to
# be available unless something actually changed.
func _on_Mute_released():
	if $Mute/Outline.visible == false:
		$Confirm.show()
		set_frame(1)
	$Mute/Outline.show()
	$Sound/Outline.hide()
	sound = 0


# ------------------------------------------------------------------------------
# Turns sound on and highlights current selection
# ------------------------------------------------------------------------------
# The check to see if the outline is visible has to before its made visible to 
# actually check. The check is there because I don't want the confirm button to
# be available unless something actually changed.
func _on_Sound_released():
	if $Sound/Outline.visible == false:
		$Confirm.show()
		set_frame(1)
	$Sound/Outline.show()
	$Mute/Outline.hide()
	sound = 1


# ------------------------------------------------------------------------------
# Turns invincibility on and highlights current selection
# ------------------------------------------------------------------------------
# The check to see if the outline is visible has to before its made visible to 
# actually check. The check is there because I don't want the confirm button to
# be available unless something actually changed.
func _on_Invincible_released():
	if $Invincible/Outline.visible == false:
		$Confirm.show()
		set_frame(1)
	$Invincible/Outline.show()
	$Death/Outline.hide()
	death = 0


# ------------------------------------------------------------------------------
# Turns death mode on and highlights current selection
# ------------------------------------------------------------------------------
# The check to see if the outline is visible has to before its made visible to 
# actually check. The check is there because I don't want the confirm button to
# be available unless something actually changed.
func _on_Death_released():
	if $Death/Outline.visible == false:
		$Confirm.show()
		set_frame(1)
	$Death/Outline.show()
	$Invincible/Outline.hide()
	death = 1


func _on_Speed_value_changed(value):
	if not initial_change:
		$Confirm.show()
		set_frame(1)


func _on_Swipe_value_changed(value):
	if not initial_change:
		$Confirm.show()
		set_frame(1)
