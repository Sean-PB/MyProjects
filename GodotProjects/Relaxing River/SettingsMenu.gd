extends AnimatedSprite2D


signal settings_confirmed
signal settings_exited


# ------------------------------------------------------------------------------
# Variables
# ------------------------------------------------------------------------------
var file_path = "user://settings.txt"   # Declaring file to save settings and score
var sound
var challenge_mode
var sound_outline_pos = Vector2(-225, -150)
var mute_outline_pos = Vector2(-90, -150)
# This var is to make sure that the initial change for speed and swipe doesn't 
# cause the confirm button to show.
var initial_change = true


# Called when the node enters the scene tree for the first time.
func _ready():
	set_frame(0)
	load_settings()


# ------------------------------------------------------------------------------
# This loads in all the current settings to the menu so the player can see
# ------------------------------------------------------------------------------
func load_settings():
	if FileAccess.file_exists(file_path):
		var file = FileAccess.open(file_path, FileAccess.READ)
		var content = file.get_as_text()
		sound = int(content.split("/")[0])
		challenge_mode = int(content.split("/")[1])
		$Swipe.value = int(content.split("/")[2])
		$Speed.value = int(content.split("/")[3])
		initial_change = false # has to be changed below the speed and swipe changes
		file.close()
		
		if sound:
			$SoundMuteOutline.position = Vector2(-225, -150)
		else:
			$SoundMuteOutline.position = Vector2(-90, -150)
		
		if challenge_mode:
			$Skull/Outline.show()
			$Invincible/Outline.hide()
		else:
			$Invincible/Outline.show()
			$Skull/Outline.hide()
		
	else:
		sound = 1
		$SoundMuteOutline.position = Vector2(-225, -150)
		challenge_mode = 1
		$Skull/Outline.show()
		$Speed.value = 250
		$Swipe.value = 35
		initial_change = false # has to be changed below the speed and swipe changes


# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
func save_settings(new_sound, new_challenge_mode, new_swipe, new_speed):
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	file.store_string((str(new_sound) + "/" + str(new_challenge_mode) + "/" + str(new_swipe)
		 + "/" + str(new_speed)))
	file.close()


# ------------------------------------------------------------------------------
# Cancels any changes the player has made to the settings
# ------------------------------------------------------------------------------
# It emits the signal exited for the Main scene and then resets the settings
# menu and sliders before hiding itself.
func _on_Cancel_pressed():
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
func _on_Confirm_pressed():
	save_settings(sound, challenge_mode, $Swipe.value, $Speed.value)
	emit_signal("settings_confirmed")
	$Confirm.hide()
	set_frame(0)
	emit_signal("settings_exited")
	hide()


func _on_Speed_value_changed(_value):
	if not initial_change:
		$Confirm.show()
		set_frame(1)


func _on_Swipe_value_changed(_value):
	if not initial_change:
		$Confirm.show()
		set_frame(1)


# ------------------------------------------------------------------------------
# Turns mute on and highlights current selection
# ------------------------------------------------------------------------------
# The check to see if the outline is visible has to before its made visible to 
# actually check. The check is there because I don't want the confirm button to
# be available unless something actually changed.
func _on_Mute_pressed():
	if $SoundMuteOutline.position == sound_outline_pos: # If not already selected
		$Confirm.show()
		set_frame(1)
		$SoundMuteOutline.position = mute_outline_pos # Change position
		sound = 0


# ------------------------------------------------------------------------------
# Turns sound on and highlights current selection
# ------------------------------------------------------------------------------
# The check to see if the outline is visible has to before its made visible to 
# actually check. The check is there because I don't want the confirm button to
# be available unless something actually changed.
func _on_Sound_pressed():
	if $SoundMuteOutline.position == mute_outline_pos: # If not already selected
		$Confirm.show()
		set_frame(1)
		$SoundMuteOutline.position = sound_outline_pos # Change position
		sound = 1


# ------------------------------------------------------------------------------
# Turns invincibility on and highlights current selection
# ------------------------------------------------------------------------------
# The check to see if the outline is visible has to before its made visible to 
# actually check. The check is there because I don't want the confirm button to
# be available unless something actually changed.
func _on_Invincible_pressed():
	if $Invincible/Outline.visible == false:
		$Confirm.show()
		set_frame(1)
	$Invincible/Outline.show()
	$Skull/Outline.hide()
	challenge_mode = 0


# ------------------------------------------------------------------------------
# Turns challenge_mode on and highlights current selection
# ------------------------------------------------------------------------------
# The check to see if the outline is visible has to before its made visible to 
# actually check. The check is there because I don't want the confirm button to
# be available unless something actually changed.
func _on_Skull_pressed():
	if $Skull/Outline.visible == false:
		$Confirm.show()
		set_frame(1)
	$Skull/Outline.show()
	$Invincible/Outline.hide()
	challenge_mode = 1
