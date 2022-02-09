extends Node

const ENEMY = preload("res://Enemy.tscn")       # Load in the Enemy scene
const LASER = preload("res://Laser.tscn")       # Load in the Laser scene
const NUKE = preload("res://Nuke.tscn")         # Load in the Nuke scene
const SHIELD = preload("res://ForceField.tscn") # Load in the ForecField scene

var rng = RandomNumberGenerator.new()
var screen_size
var nuke = NUKE.instance()
var nuke_active = false
var nuke_available
var num_of_enemies
var shields_remaining = 3
var nuke_ad = false
var shield_ad = false
var nuke_failed_once
var shield_failed_once
var ad_loaded = false
onready var admob = $AdMob


func _ready():
	loadAds()
	$HUD.pause_mode 
	$SplashScreen.connect("splash_done", self, "splash_done")


func loadAds():
	admob.load_banner()
	admob.load_rewarded_video()


func new_game():
	admob.hide_banner()
	$Background/AnimatedSprite.stop()     # Stopss animation if there was a previous game
	$Player.playing = true                   # Enables player input
	$Music.play()                            # Starts musci loop
	$Player.set_position(Vector2(512, 600))  # Setting players starting position
	$Player.show()                           # Showing player
	
	# Showing controls
	$Controls/Buttons.show()
	$Controls/Buttons/Nuke.show()
	$Controls/Buttons/Shield.show()
	
	# Hiding things
	$HUD/PlayerSkinSelector.hide()
	
	# Player info reset and showing
	$HUD/LaserRechargeBar/TextureProgress.value = 100  # Fill laser recharge bar
	$HUD/LaserRechargeBar.show()             # Show laser recharge bar
	shields_remaining = 3
	$Controls.shields_remaining(shields_remaining)
	num_of_enemies = 0                       # Enemies on screen = 0
	nuke_failed_once = true                    # Reseting 1 free nuke on ad failure
	shield_failed_once = true                  # Reseting 1 free shield on ad failure
	nuke_available = true
	
	spawn_enemy()                            # Spawn 1 enemy at begining of game


func game_over():
	admob.show_banner()
	if nuke_active:
		remove_child(nuke)                        # Removes nuke from scene without removing instance
	$Player.playing = false                  # Disabels player input
	$Music.stop()                            # Ends music loop
	$"Game Over".play()                      # Play game over sound
	$HUD/Pause.hide()                        # Hides pause button immediatley to avoid issues
	get_tree().call_group("enemies", "queue_free")     # Removes all enemies
	get_tree().call_group("lasers", "queue_free")      # Removes all lasers
	$Controls/Buttons.hide()
	$HUD/LaserRechargeBar.hide()             # Hide laser recharge bar
	$Controls/NukeAd.hide()
	$Controls/ShieldAd.hide()                # Hide shield ad button
	$Player/AnimatedSprite.frame = 1         # Skips to fireball
	$Player/AnimatedSprite.play()            # Player blows up
	yield($Player/AnimatedSprite, "animation_finished")  # Wait till done blowing up
	$Player/AnimatedSprite.stop()            # Stops animation for future games
	$Player/AnimatedSprite.frame = 0         # Sets animated sprite to ship
	$Player.hide()                           # Hides player
	$HUD.show_game_over_pt_1()               # Show the game over text part
	$Background/AnimatedSprite.frame = 1    # Skips to alien planting flag
	$Background/AnimatedSprite.play()       # Alien plants flag
	yield($Background/AnimatedSprite, "animation_finished")  # Wait a sec
	$Background/AnimatedSprite.stop()       # Stops aniimation for furture games
	$Background/AnimatedSprite.frame = 0    # Resets animation to just earth
	$HUD.show_game_over_pt_2()                # Lets you start new game


func _process(delta):
	# Nuke check
	if nuke_active: # This is to prevent a null nuke from being called in the next line
		if nuke.get_explode() and $Player.playing: # If the nuke has reached detination point while game is playing
			get_tree().call_group("enemies", "queue_free")  # Removes all enemies
			get_tree().call_group("lasers", "queue_free")   # Removes all lasers
			nuke.get_node("Explosion").show()               # Show animated sprite
			nuke.get_node("Explosion").play()               # Play animation
			nuke.get_node("Nuke_sound").play()
			$HUD/LaserRechargeBar.hide()
			$Music.stop()
			nuke_active = false                             # Resets nuke_active boolean
			yield(nuke.get_node("Explosion"), "animation_finished") # When done...
			$HUD/Score.text = str(int($HUD/Score.text) + num_of_enemies)
			$HUD/LaserRechargeBar.hide()
			nuke.get_node("Explosion").stop()               # Stpp animated sprite
			nuke.get_node("Explosion").hide()               # Hide animation
			remove_child(nuke)                              # Removes nuke from scene without removing instance
			$Music.play()
			$HUD/LaserRechargeBar.show()
			num_of_enemies = 0                              # Reset number of enemies
			spawn_enemy()                                   # Spawns 1 enemy
	
	# Enemy hit check
	for i in get_tree().get_nodes_in_group('enemies'):     # Loop through all enemies
		if i.get_hit() == true and i.get_exploding() == false:  # If hit and not already exploding
			i.play_animation()
			$Explosion.play()                    # Sound of enemy exploding
			num_of_enemies -= 1
			# Spawning 2 new enemies in random locations
			spawn_enemy()
			spawn_enemy()
			# Add 1 to score when hit
			$HUD/Score.text = str(int($HUD/Score.text) + 1)
			
	if !$Player.has_node("ForceField") and shields_remaining > 0:
		$Controls.disable_shield_button(false)
		


func on_shoot():                      # When the player signal shoot is sent
	if $HUD/LaserRechargeBar/TextureProgress.value >= 20: # Only fire if recharged enough (1/5 seconds)
		var laser = LASER.instance()          # Make an instance of laser
		laser.set_position($Player.position)  # Set laser position to where the player is
		add_child(laser)                      # Add the laser scene to the main scene
		$HUD/LaserRechargeBar/TextureProgress.value -= 20


func on_nuke():
	nuke.set_position($Player.position)                # Shoot from player posiion
	add_child(nuke)                                    # Add nuke to tree
	nuke.get_node("Missile_sound").play()
	nuke_active = true                                 # Nuke is active
	nuke.explode = false
	nuke_available = false


func on_shield():
	var shield = SHIELD.instance()
	$Player.add_child(shield)
	shields_remaining -= 1
	$Controls.shields_remaining(shields_remaining)
	if shields_remaining <= 0:
		$Controls/Buttons/Shield.hide()
		$Controls/ShieldAd.show()
	else:
		if shield.get_node("Timer").time_left >= 0:
			$Controls.disable_shield_button(true)


func spawn_enemy():                           # Spawns enemy
	var enemy = ENEMY.instance()
	num_of_enemies += 1                       # adds 1 to active enemy count
	add_child(enemy)


func _on_Player_area_entered(area):
	if !$Player.has_node("ForceField"):
		area.queue_free()                         # Removes whatever hit player
		game_over()                               # Calls game over function


func _on_HUD_paused():         # When the pause button is pressed,
	$Controls/Buttons.hide()        # Hide controls
	get_tree().paused = true        # Pause game
	$HUD/Score.text = "\n" + $HUD/Score.text   # Lowers score under banner
	$AdMob.show_banner()            # Show banner


func _on_HUD_resume():         # When resume button is pressed
	$Controls/Buttons.show()        # Showing controls
	get_tree().paused = false       # Unpause game
	$AdMob.hide_banner()            # Hide banner
	if "\n" in $HUD/Score.text:
		$HUD/Score.text = $HUD/Score.text.substr(1, -1)  # Raises score back to top
	# Shows ads after resuming if needed
	if nuke_available == false:
		$Controls/NukeAd.show()
	if shields_remaining == 0:
		$Controls/ShieldAd.show()


func _on_Controls_nuke_ad():
	nuke_ad = true
	if ad_loaded:
		admob.show_rewarded_video()                   # Show video
	else:
		_on_AdMob_rewarded_video_failed_to_load()
	

func _on_Controls_shield_ad():
	shield_ad = true
	if ad_loaded:
		admob.show_rewarded_video()                   # Show video
	else:
		_on_AdMob_rewarded_video_failed_to_load()


func _on_AdMob_rewarded_video_closed():        # When the ad video is closed,
	ad_loaded = false
	admob.load_rewarded_video()                   # Reload an ad video
	# Pauses game
	$Controls/Buttons.hide()        # Hide controls
	get_tree().paused = true        # Pause game
	$AdMob.show_banner()            # Shows banner
	$HUD/Score.text = "\n" + $HUD/Score.text   # Lowers score under banner
	$HUD/Pause.hide()
	$HUD/Resume.show()
	$HUD.show_message("Paused")


func _on_AdMob_rewarded(currency, ammount):
	if nuke_ad == true:         # If that ad was from the nuke button
		$Controls/Buttons/Nuke.show()
		$Controls/NukeAd.hide()
		nuke_ad = false             # and reset the boolean
		nuke_available = true
	elif shield_ad == true:     # If that ad was from the shield button
		shields_remaining += 1               # Give player additional shield
		$Controls.shields_remaining(shields_remaining)  # Set on screen number
		if $Player.has_node("ForceField"):
			$Controls.disable_shield_button(true)
		$Controls/Buttons/Shield.show()      # Show shield button again
		$Controls/ShieldAd.hide()            # Hide ad button
		shield_ad = false                    # and reset the boolean


func _on_AdMob_rewarded_video_failed_to_load():  # When reward vid doesn't load
	ad_loaded = false
	admob.load_rewarded_video()      # Reload an ad video
	get_tree().paused = true         # Pause game
	$HUD/Resume.show()               # Show resume button
	$HUD/Pause.hide()                # Hide pause button
	$Controls/Buttons.hide()         # Hide controls
	$Controls/NukeAd.hide()
	$Controls/ShieldAd.hide()
	$AdMob.show_banner()             # Shows banner
	if $HUD/Score.text.substr(0, 1) != "\n": # If the number isn't already lowered
		$HUD/Score.text = "\n" + $HUD/Score.text   # Lowers score under banner
	if nuke_ad == true:
		if nuke_failed_once:      # If its the first time the ad failed to load this game
			$HUD.show_message("Rewarded Video Ad Failed to load.\nEnjoy a free nuke on us!")
			$Controls/Buttons/Nuke.show()   # Give another nuke
			$Controls/NukeAd.hide()         # Hide the nuke ad
			nuke_ad = false                 # and reset the boolean
			nuke_failed_once = false        # reset the 1 free ad failed nuke
			nuke_available = true
		else:      # If its not the first time the ad failed to load this game
			$HUD.show_message("Rewarded Video Ad Failed to load.")
			$Controls/NukeAd.show()         # Show the ad button again
			nuke_ad = false
	elif shield_ad == true:
		if shield_failed_once:
			$HUD.show_message("Rewarded Video Ad Failed to load.\nEnjoy a free shield on us!")
			$Controls/Buttons/Shield.show()  # Give another shield
			if $Player.has_node("ForceField"):
				$Controls.disable_shield_button(true)
			$Controls/ShieldAd.hide()        # Hide the shield ad
			shields_remaining += 1           # Give player additional shield
			$Controls.shields_remaining(shields_remaining)# Set on screen number
			shield_ad = false
			shield_failed_once = false
		else:
			$HUD.show_message("Rewarded Video Ad Failed to load.")
			$Controls/ShieldAd.show()
			shield_ad = false


func _on_HUD_help_pressed():        # If the help button is pressed,
	admob.hide_banner()                  # Hide the banner


func _on_HUD_exit_help():            # If the exit help button is pressed
	if get_tree().paused == false:       # and if not paused,
		admob.show_banner()                  # show banner


func _on_AdMob_rewarded_video_loaded():
	ad_loaded = true


func splash_done():
	$HUD/StartButton.show()
	$HUD/Help.show()
	$HUD/Mute.show()
	$HUD/Message.show()
	$HUD/HighScore.show()
