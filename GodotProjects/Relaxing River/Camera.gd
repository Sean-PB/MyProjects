extends Camera2D

var shake_amount = 0
var default_offset = offset

func _ready():
	set_process(false)


func _process(delta):
	offset = Vector2(randf_range(-shake_amount, shake_amount), randf_range(shake_amount, -shake_amount)) * delta + default_offset


func shake(new_shake, shake_time = 1, shake_limit = 300):
	var tween = create_tween()
	shake_amount += new_shake
	if shake_amount > shake_limit:
		shake_amount = shake_limit
	$Timer.wait_time = shake_time
	tween.stop()
	set_process(true)
	$Timer.start()

func _on_Timer_timeout():
	shake_amount = 0
	set_process(true)
