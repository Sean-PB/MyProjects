extends Node2D

# Variables
var started = false
var dodged
var player_alive
var enemy_bullets
var player_bullets
var rng = RandomNumberGenerator.new()
var player_choice
var random_number
var mute
var vibrate
var help


# Called when the node enters the scene tree for the first time.
func _ready():
	$Camera2D.position = Vector2(240, 450)
	player_alive = true
	player_choice = ""
	$Camera2D/Cylinder.animation = "Empty"
	$AdMob.load_banner()
	mute = false
	help = false
	vibrate = false
	$SplashScreen.connect("splash_done", self, "splash_done")


# Game process (second by second)
func _process(delta):
	# Pie timer fill equal to move timer
	$PlayerMoveTimerVisual.material.set("shader_param/fill_ratio", $PlayerMoveTimer.time_left)
	
	# If player dies or draws
	if started == true and player_alive == false:
		# Scroll camera up
		if $Camera2D.position.y > -900:
			if $DeadTimer.time_left == 0:
				$Camera2D.position.y -= 1250 * delta
				if $DeadSound.playing == false:
					$LoadSound.stop()
					$DeadSound.play()
		else:
			$Camera2D.position.y = -900
			if $Camera2D/FadeColor.visible == false:
				$FallSoundClose.play()
				$Camera2D/FadeAnimation.play("FadeToBlack")
				$Camera2D/FadeColor.visible = true
				yield($Camera2D/FadeAnimation, "animation_finished")
				$Camera2D/Restart1.visible = true
				$Camera2D/MessageArt.visible = true
				$Camera2D/MessageArt/DeadMessage.visible = true
				
				
		# Scale down foreground
		if $Background/Foreground.scale > Vector2(0.8, 0.8):
			if $DeadTimer.time_left == 0:
				$Background/Foreground.scale -= Vector2(0.25 * delta, 0.25 * delta)
	
	# Dodge movement
	if player_choice == "DODGE" and dodged == false:
		# Scroll camera down
		if $Camera2D.position.y < 610:
			$Camera2D.position.y += 450 * delta
		# Stop scrolling down
		else:
			$Camera2D.position.y = 610
			dodged = true
			$DodgeTimer.start()
	if player_choice == "DODGE" and dodged == true:
		# Scroll camera up
		if $Camera2D.position.y > 450:
			if $DodgeTimer.time_left == 0.0:
				$Camera2D.position.y -= 450 * delta
		# Stop scrolling up
		else:
			$Camera2D.position.y = 450


func _on_Rumble1_timeout():
	if vibrate: 
		Input.vibrate_handheld(200)
	$Rumble2.start()


func _on_Rumble2_timeout():
	if vibrate: 
		Input.vibrate_handheld(200)
	rng.randomize()
	
	# 0 = Dodge
	# 1 = Load
	# 2 = Shoot
	if enemy_bullets == 0: # 75% Load, 25% dodge
		random_number = rng.randi_range(1, 100)
		if random_number <= 75: random_number = 1
		else: random_number = 0
	elif enemy_bullets == 1: # 33% shoot, 33% Load, 33% dodge
		random_number = rng.randi_range(0, 2)
	elif enemy_bullets == 2: # 47% shoot, 26% Load, 27% dodge
		random_number = rng.randi_range(1, 100)
		if random_number <= 47: random_number = 2
		elif random_number >= 73: random_number = 0
		else: random_number = 1
	elif enemy_bullets == 3: # 61% shoot, 20% Load, 19% dodge
		random_number = rng.randi_range(1, 100)
		if random_number <= 61: random_number = 2
		elif random_number >= 80: random_number = 0
		else: random_number = 1
	elif enemy_bullets == 4: # 75% shoot, 13% Load, 12% dodge
		random_number = rng.randi_range(1, 100)
		if random_number <= 75: random_number = 2
		elif random_number >= 87: random_number = 0
		else: random_number = 1
	elif enemy_bullets == 5: # 89% shoot, 6% Load, 5% dodge
		random_number = rng.randi_range(1, 100)
		if random_number <= 89: random_number = 2
		elif random_number >= 95: random_number = 0
		else: random_number = 1
	elif enemy_bullets == 6: # 100% shoot
		random_number = 2

	# Start move timer
	$PlayerMoveTimer.start()
	
	
	# Enable buttons
	if player_bullets > 0:
		$Fire.visible = true
	if player_bullets < 6:
		$Load.visible = true
	$Dodge.visible = true
	$PlayerMoveTimerVisual.visible = true


func _on_PlayerMoveTimer_timeout():
	show_moves()


func show_moves():
	# Disable buttons
	$Fire.visible = false
	$Load.visible = false
	$Dodge.visible = false
	$PlayerMoveTimerVisual.visible = false
	
	# Show enemy move
	# 0 = Dodge
	# 1 = Load
	# 2 = Shoot
	if random_number == 0:
		$EnemyText.set_text("DODGING")
		$Background/Foreground/Enemy.frame = 0
		$Background/Foreground/Enemy.play("dodge")
	elif random_number == 1:
		$EnemyText.set_text("LOADING")
		enemy_bullets += 1
		$Background/Foreground/Enemy.frame = 0
		$Background/Foreground/Enemy.play("load")
		if player_choice != "SHOOT":
			$EnemyLoadSound.play()
	else:
		$EnemyText.set_text("SHOOTING")
		enemy_bullets -= 1
		$Background/Foreground/Enemy.frame = 0
		$Background/Foreground/Enemy.play("shoot")
		# Play enemy shot sound (delayed if player is shooting too)
		if player_choice == "SHOOT":
			$GunfireTimer.start()
		else:
			$GunfireFar.play()
	
	# Decicions
	# Victory
	if player_choice == "SHOOT" and random_number == 1:
		$Camera2D/MessageArt/VictoryMessage.set_text("VICTORY")
		$Camera2D/MessageArt.frame = 0
		$Camera2D/Pause.visible = false
		$Camera2D/Cylinder.visible = false
		$Background/Foreground/Enemy.play("die")
		$Camera2D/FadeAnimation.play("FadeToWhite")
		$Camera2D/FadeColor.visible = true
		$Music.stop()
		$WinSound.play()
		yield($Background/Foreground/Enemy, "animation_finished")
		$FallSoundFar.play()
		yield($Camera2D/FadeAnimation, "animation_finished")
		$Camera2D/Restart2.visible = true
		$Camera2D/MessageArt.visible = true
		$Camera2D/MessageArt/VictoryMessage.visible = true
	# Tie
	elif player_choice == "SHOOT" and random_number == 2:
		$Camera2D/MessageArt/DeadMessage.set_text("TIE")
		$Music.stop()
		$Camera2D/MessageArt.frame = 2
		player_alive = false
		$Camera2D/Cylinder.visible = false
		$Camera2D/Pause.visible = false
		$DeadTimer.start()
	# Loss
	elif (player_choice == "LOAD" or player_choice == "") and random_number == 2:
		$Camera2D/MessageArt/DeadMessage.set_text("DEAD")
		$Music.stop()
		$Camera2D/MessageArt.frame = 1
		player_alive = false
		$Camera2D/Cylinder.visible = false
		$Camera2D/Pause.visible = false
		$DeadTimer.start()
	# Keep playing
	else:
		# Show for 1 second
		$ShowTimer.start()


func _on_ShowTimer_timeout():
	$EnemyText.set_text("")
	player_choice = ""
	# Restart timer
	$Rumble1.start()


# Buttons
func _on_Fire_released():
	# Disable buttons
	$Fire.visible = false
	$Load.visible = false
	$Dodge.visible = false
	$PlayerMoveTimerVisual.visible = false
	match player_bullets:
		1:
			$Camera2D/Cylinder.play("Empty-One", true)
		2:
			$Camera2D/Cylinder.play("One-Two", true)
		3:
			$Camera2D/Cylinder.play("Two-Three", true)
		4:
			$Camera2D/Cylinder.play("Three-Four", true)
		5:
			$Camera2D/Cylinder.play("Four-Five", true)
		6:
			$Camera2D/Cylinder.play("Five-Six", true)
			
	player_choice = "SHOOT"
	player_bullets -= 1
	$PlayerMoveTimer.stop()
	$GunfireClose.play()
	show_moves()


func _on_Load_released():
	# Disable buttons
	$Fire.visible = false
	$Load.visible = false
	$Dodge.visible = false
	$PlayerMoveTimerVisual.visible = false
	match player_bullets:
		0:
			$Camera2D/Cylinder.play("Empty-One")
		1:
			$Camera2D/Cylinder.play("One-Two")
		2:
			$Camera2D/Cylinder.play("Two-Three")
		3:
			$Camera2D/Cylinder.play("Three-Four")
		4:
			$Camera2D/Cylinder.play("Four-Five")
		5:
			$Camera2D/Cylinder.play("Five-Six")
			
	player_choice = "LOAD"
	player_bullets += 1
	$PlayerMoveTimer.stop()
	$LoadSound.play()
	show_moves()


func _on_Dodge_released():
	# Disable buttons
	$Fire.visible = false
	$Load.visible = false
	$Dodge.visible = false
	$PlayerMoveTimerVisual.visible = false
	dodged = false
	player_choice = "DODGE"
	$PlayerMoveTimer.stop()
	show_moves()



func _on_Restart_released():
	player_alive = true
	started = false
	enemy_bullets = 0
	player_bullets = 0
	$DeadSound.stop()
	$WinSound.stop()
	$Camera2D/Cylinder.animation = "Empty"
	$Background/Foreground/Enemy.stop()
	$Background/Foreground/Enemy.animation = "draw"
	$Background/Foreground/Enemy.frame = 0
	player_choice = ""
	$Camera2D/MessageArt/DeadMessage.set_text("")
	$Camera2D/MessageArt/VictoryMessage.set_text("")
	$EnemyText.set_text("")
	$Camera2D/Restart1.visible = false
	$Camera2D/Restart2.visible = false
	$Draw.visible = true
	$Camera2D/FadeColor.visible = false
	$Camera2D/FadeAnimation.stop(true)
	$Camera2D/FadeColor.color = "00ffffff"
	$Background/Foreground.scale = Vector2(1, 1)
	$Camera2D.position = Vector2(240, 450)
	$Load.visible = false
	$Fire.visible = false
	$Dodge.visible = false
	$PlayerMoveTimerVisual.visible = false
	$Camera2D/MessageArt.visible = false
	$Camera2D/MessageArt/DeadMessage.visible = false
	$Camera2D/MessageArt/VictoryMessage.visible = false
	if mute:
		$Camera2D/Sound.visible = true
	else:
		$Camera2D/Mute.visible = true
	if vibrate:
		$Camera2D/VibrateOff.visible = true
	else:
		$Camera2D/VibrateOn.visible = true
	$Camera2D/Help.visible = true
	


func _on_Draw_released():
	enemy_bullets = 0
	player_bullets = 0
	started = true
	$Draw.visible = false
	$Camera2D/Sound.visible = false
	$Camera2D/Mute.visible = false
	$Camera2D/VibrateOff.visible = false
	$Camera2D/VibrateOn.visible = false
	$Camera2D/Help.visible = false
	$Camera2D/Pause.visible = true
	$Camera2D/Cylinder.visible = true
	$Rumble1.start()
	$Background/Foreground/Enemy.play("draw")
	$Music.play()


func _on_Pause_released():
	get_tree().paused = true        # Pause game
	$GrayscaleShader.visible = true
	$Camera2D/Pause.visible = false
	$Camera2D/Unpause.visible = true
	if mute:
		$Camera2D/Sound.visible = true
	else:
		$Camera2D/Mute.visible = true
	if vibrate:
		$Camera2D/VibrateOff.visible = true
	else:
		$Camera2D/VibrateOn.visible = true
	$Camera2D/Help.visible = true


func _on_Unpause_released():
	get_tree().paused = false        # Unpause game
	$GrayscaleShader.visible = false
	$GrayscaleShader2.visible = false
	$Camera2D/Instructions.visible = false
	help = false
	$Camera2D/Unpause.visible = false
	$Camera2D/Pause.visible = true
	$Camera2D/Sound.visible = false
	$Camera2D/Mute.visible = false
	$Camera2D/VibrateOff.visible = false
	$Camera2D/VibrateOn.visible = false
	$Camera2D/Help.visible = false


func _on_GunfireTimer_timeout():
	$GunfireFar.play()


func _on_Sound_released():
	mute = false
	$Camera2D/Mute.show()
	$Camera2D/Sound.hide()
	AudioServer.set_bus_mute(0, false)


func _on_Mute_released():
	mute = true
	$Camera2D/Mute.hide()
	$Camera2D/Sound.show()
	AudioServer.set_bus_mute(0, true)



func _on_Help_released():
	if help == false:         # clicking it open
		help = true
		$Camera2D/Instructions.visible = true
		$GrayscaleShader2.visible = true
		$Draw.hide()
		if started == false:     # On draw screen
			get_tree().paused = true        # Pause game
	else:                     # clicking it closed
		help = false
		$Camera2D/Instructions.visible = false
		$GrayscaleShader2.visible = false
		if started == false:     # On draw screen
			get_tree().paused = false       # Unpause game
			$Draw.show()

func splash_done():
	$Draw.show()
	$Camera2D/Help.show()
	$Camera2D/Mute.show()
	$Camera2D/VibrateOn.show()


func _on_VibrateOn_pressed():
	vibrate = true
	$Camera2D/VibrateOn.hide()
	$Camera2D/VibrateOff.show()
	


func _on_VibrateOff_pressed():
	vibrate = false
	$Camera2D/VibrateOn.show()
	$Camera2D/VibrateOff.hide()


func _on_Music_finished():
	if player_alive and not $Camera2D/FadeColor.visible:
		$Music.play()
