extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_HairColor_color_changed(color):
	$Character/LongHair.material.set("shader_param/NEWCOLOR", color)
	$Character/ShortHair.material.set("shader_param/NEWCOLOR", color)
	$Long.material.set("shader_param/NEWCOLOR", color)
	$Short.material.set("shader_param/NEWCOLOR", color)
	


func _on_BodyColor_color_changed(color):
	$Character.material.set("shader_param/NEWCOLOR", color)
	$Skin.material.set("shader_param/NEWCOLOR", color)


func _on_Short_pressed():
	$Character/LongHair.hide()
	$Character/ShortHair.show()
	$HairOutline.frame = 0
	$HairOutline.position = Vector2(118, -173)


func _on_Long_pressed():
	$Character/ShortHair.hide()
	$Character/LongHair.show()
	$HairOutline.frame = 1
	$HairOutline.position = Vector2(238, -163)
