extends AnimatedSprite

func change_animation(color, motion):
	match color:
		"dark_black":
			match motion:
				"idle":
					animation = "dark_black_idle"
				"left":
					animation = "dark_black_left"
				"right":
					animation = "dark_black_right"
				"straight":
					animation = "dark_black_straight"
		
		"light_black":
			match motion:
				"idle":
					animation = "light_black_idle"
				"left":
					animation = "light_black_left"
				"right":
					animation = "light_black_right"
				"straight":
					animation = "light_black_straight"
		
		"middle":
			match motion:
				"idle":
					animation = "middle_idle"
				"left":
					animation = "middle_left"
				"right":
					animation = "middle_right"
				"straight":
					animation = "middle_straight"
		
		"dark_white":
			match motion:
				"idle":
					animation = "dark_white_idle"
				"left":
					animation = "dark_white_left"
				"right":
					animation = "dark_white_right"
				"straight":
					animation = "dark_white_straight"
		
		"light_white":
			match motion:
				"idle":
					animation = "light_white_idle"
				"left":
					animation = "light_white_left"
				"right":
					animation = "light_white_right"
				"straight":
					animation = "light_white_straight"
		
		_:
			match motion:
				"idle":
					animation = "middle_idle"
				"left":
					animation = "middle_left"
				"right":
					animation = "middle_right"
				"straight":
					animation = "middle_straight"
			
