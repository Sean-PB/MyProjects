extends Sprite2D

signal splash_done

func _ready():
	show()
	$Timer.start()


func _on_Timer_timeout():
	emit_signal("splash_done")
	queue_free()
