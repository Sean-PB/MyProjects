extends Control

var skin
var hair


func _ready():
	$Hair.hide()


func _on_Back_pressed():
	hide()


func _on_DarkBlack_pressed():
	skin = "dark_black"
	$Skin.hide()
	$Hair.show()


func _on_LightBlack_pressed():
	skin = "light_black"
	$Skin.hide()
	$Hair.show()


func _on_Middle_pressed():
	skin = "middle"
	$Skin.hide()
	$Hair.show()


func _on_DarkWhite_pressed():
	skin = "dark_white"
	$Skin.hide()
	$Hair.show()


func _on_LightWhite_pressed():
	skin = "light_white"
	$Skin.hide()
	$Hair.show()


func _on_Red_pressed():
	pass # Replace with function body.


func _on_Black_pressed():
	pass # Replace with function body.


func _on_Brown_pressed():
	pass # Replace with function body.


func _on_Blonde_pressed():
	pass # Replace with function body.


func _on_Bald_pressed():
	pass # Replace with function body.
