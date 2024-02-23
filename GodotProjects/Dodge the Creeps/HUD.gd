extends CanvasLayer

var score_file = "user://highscore.txt"   # To save the highscore in
var high_score = 0

signal start_game

func _ready():
	load_score()   # Loads in the highscore
	$HighScore.text = $HighScore.text + str(high_score) # Adds high score to text

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	if int($ScoreLabel.text) > int($HighScore.text.substr(12, -1)):
		$HighScore.text = $HighScore.text.substr(0, 12) + $ScoreLabel.text
		high_score = $ScoreLabel.text
		save_score()
	else:
		load_score()
		$HighScore.text = $HighScore.text.substr(0, 12) + str(high_score)
	$HighScore.show()
	# Wait until the Message Timer has counted down
	await $MessageTimer.timeout
	
	$Message.text = "Dodge the\nCreeps!"
	$Message.show()
	# Make a one-shot timer and wait for it to finish
	await get_tree().create_timer(1).timeout
	$StartButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)

func _on_StartButton_pressed():
	$StartButton.hide()
	$HighScore.hide()
	emit_signal("start_game")
	
func _on_MessageTimer_timeout():
	$Message.hide()

func load_score():
	var f = File.new()
	if f.file_exists(score_file):
		f.open(score_file, File.READ)
		var content = f.get_as_text()
		high_score = int(content)
		f.close()

func save_score():
	var f = File.new()
	f.open(score_file, File.WRITE)
	f.store_string(str(high_score))
	f.close()
