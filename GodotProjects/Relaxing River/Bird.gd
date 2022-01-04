extends KinematicBody2D


var light_blue = Color("0000ff")
var blue = Color("0000c5")
var dark_blue = Color("000088")

var light_yellow = Color("fffc00")
var yellow = Color("fffc00")
var dark_yellow = Color("828000")

var light_green = Color("05f200")
var green = Color("04c800")
var dark_green = Color("038200")

var light_purple = Color("c100fd")
var purple = Color("8f00ba")
var dark_purple = Color("660086")

var light_red = Color("fd0000")
var red = Color("c40000")
var dark_red = Color("860000")

var light_grey = Color("636161")
var grey = Color("3e3e3e")
var dark_grey = Color("202020")

var rng = RandomNumberGenerator.new()
var speed = 225


# --------------------------------------------------------------------------------------------------
# Called when Scene is first loaded
# --------------------------------------------------------------------------------------------------
# Rng choose the color of the bird
func _ready():
	rng.randomize()
	var color = rng.randi_range(0, 5)
	if color == 0:
		$AnimatedSprite.material.set("shader_param/NEWCOLOR1", light_blue)
		$AnimatedSprite.material.set("shader_param/NEWCOLOR2", blue)
		$AnimatedSprite.material.set("shader_param/NEWCOLOR3", dark_blue)
	elif color == 1:
		$AnimatedSprite.material.set("shader_param/NEWCOLOR1", light_yellow)
		$AnimatedSprite.material.set("shader_param/NEWCOLOR2", yellow)
		$AnimatedSprite.material.set("shader_param/NEWCOLOR3", dark_yellow)
	elif color == 2:
		$AnimatedSprite.material.set("shader_param/NEWCOLOR1", light_green)
		$AnimatedSprite.material.set("shader_param/NEWCOLOR2", green)
		$AnimatedSprite.material.set("shader_param/NEWCOLOR3", dark_green)
	elif color == 3:
		$AnimatedSprite.material.set("shader_param/NEWCOLOR1", light_purple)
		$AnimatedSprite.material.set("shader_param/NEWCOLOR2", purple)
		$AnimatedSprite.material.set("shader_param/NEWCOLOR3", dark_purple)
	elif color == 4:
		$AnimatedSprite.material.set("shader_param/NEWCOLOR1", light_red)
		$AnimatedSprite.material.set("shader_param/NEWCOLOR2", red)
		$AnimatedSprite.material.set("shader_param/NEWCOLOR3", dark_red)
	else:
		$AnimatedSprite.material.set("shader_param/NEWCOLOR1", light_grey)
		$AnimatedSprite.material.set("shader_param/NEWCOLOR2", grey)
		$AnimatedSprite.material.set("shader_param/NEWCOLOR3", dark_grey)


# ------------------------------------------------------------------------------
# Called every frame. 'delta' is the elapsed time since the previous frame.
# ------------------------------------------------------------------------------
func _process(_delta):
	move_and_slide(Vector2(0, -speed))


# ------------------------------------------------------------------------------
# Delete self once off screen
# ------------------------------------------------------------------------------
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
