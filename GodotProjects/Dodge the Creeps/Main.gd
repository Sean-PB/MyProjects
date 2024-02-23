extends Node

@export var Mob: PackedScene  # Allows us to choose the Mob scene we want to instance.
var score

func _ready():
	randomize()

func game_over():           # When the hit signal is recieved, run this method
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	get_tree().call_group("mobs", "queue_free")
	$Music.stop()
	$DeathSound.play()
	$Joystick/Joysitck_Button.position =  Vector2(-32.000004, -32.000004)
	$Joystick.hide()

func new_game():      # Connected to the HUDs custom start_game signal
	score = 0
	$Player.start($StartPosition.position)
	$Player/AnimatedSprite2D.flip_v = false
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Music.play()
	$Joystick.show()

func _on_MobTimer_timeout():
	# Choose a random location on Path2D.
	$MobPath/MobSpawnLocation.offset = randi()
	# Create a Mob instance and add it to the scene.
	var mob = Mob.instantiate()
	add_child(mob)
	# Set the mob's direction perpendicular to the path direction.
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
	# Set the mob's position to a random location.
	mob.position = $MobPath/MobSpawnLocation.position
	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	# Set the velocity (speed & direction)
	mob.linear_velocity = Vector2(randf_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)
	


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
