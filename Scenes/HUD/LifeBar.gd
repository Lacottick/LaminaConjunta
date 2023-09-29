extends TextureRect

class_name HealthBar



func update(vida_atual, player):
	match(vida_atual):
		2:
			texture = load("res://Assets/HUD/Vida"+player+"Middle.png")
		1:
			texture = load("res://Assets/HUD/Vida"+player+"One.png")
		0:
			texture =  load("res://Assets/HUD/Vida"+player+"Zero.png")
		_:
			texture = load("res://Assets/HUD/Vida"+player+"Full.png")
