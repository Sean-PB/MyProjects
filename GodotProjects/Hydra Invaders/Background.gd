extends Node

func _ready():
	$AnimatedSprite.frame = 0

func _on_Earth_area_entered(area):
	if area.name == "Enemy":
		emit_signal("landed")
