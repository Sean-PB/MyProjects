extends Node2D

func _ready():
	$Camera2D.position = Vector2(96, -120)        # Set camera position (change 96 to 95) !!!!!!!!!!!

func _process(delta):
	$Camera2D.position.y = $Player.position.y
