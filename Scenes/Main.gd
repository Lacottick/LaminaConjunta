extends Node2D

func _ready():
	var player_one : = Player.new("w", "s", "d", "a", 1)
	var player_two : = Player.new("ui_up", "ui_down", "ui_right", "ui_left", 1)
	player_one.position = Vector2(400, 200)
	player_two.position = Vector2(600, 200)
	player_two.modulate = Color.RED
	add_child(player_one)
	add_child(player_two)


func _process(delta):
	pass
