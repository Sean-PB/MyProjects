extends Area2D

func _ready():
	add_to_group("friendly")
	$Timer.start()

func _on_ForceField_area_entered(area):
	if !area.is_in_group("friendly"):    # If not a friendly item,
		area.speed = 0
		if area.is_in_group("enemies"):     # if is an enemy ship,
			area.force_field_explosion()                    # Set hit as true
		if area.is_in_group("lasers"):    # if is an enmey laser,
			area.explode()                   # Remove laser


func _on_Timer_timeout():
	$AnimatedSprite.play()
	yield($AnimatedSprite, "animation_finished")
	queue_free()
	get_parent().get_parent().get_node("Controls").disable_shield_button(false)
