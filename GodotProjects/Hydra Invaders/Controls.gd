extends Node

signal shoot
signal nuke
signal shield
signal nuke_ad
signal shield_ad

var direction = 0


func _ready():
	$NukeAd.hide()           # Hide ad buttons until later
	$ShieldAd.hide()         # Hide ad buttons until later
	$Buttons.hide()          # Hide all buttons at first
	$Buttons/DisabeldShield.hide()


func disable_shield_button(x):
	if x:
		$Buttons/DisabeldShield.show()
		$Buttons/Shield.hide()
	else:
		$Buttons/DisabeldShield.hide()
		if get_parent().shields_remaining > 0:
			$Buttons/Shield.show()


func shields_remaining(x):
	$Buttons/Shield/ShieldsRemaining.text = str(x)
	$Buttons/DisabeldShield/ShieldsRemaining.text = str(x)


func get_value():                       # This is how the left or right movement
	return direction                    # is translated to the player


func _on_ShieldAd_pressed():            # If shield ad is pressed
	emit_signal("shield_ad")


func _on_NukeAd_pressed():              # If nuke ad is pressed
	emit_signal("nuke_ad")


func _on_Nuke_pressed():                # If nuke is pressed
	emit_signal("nuke")
	$Buttons/Nuke.hide()                # Hide nuke button after 1 shot
	$NukeAd.show()                      # Show nuke ad to get another nuke


func _on_Shield_pressed():              # If shield is pressed
	emit_signal("shield")


func _on_Shoot_pressed():              # Shoot laser
	emit_signal("shoot")


# Movement
func _on_Right_pressed():               # Move right
	direction = 1


func _on_Left_pressed():                # Move left
	direction = -1


func _on_Right_released():              # Stop moving
	direction = 0


func _on_Left_released():               # Stop moving
	direction = 0
