extends StaticBody2D

var damage = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func attack(input_direction):
	if(input_direction.length() > 0):
		if(input_direction.y == -1):
			position += Vector2(0, -40)
		elif(input_direction.y == 1):
			get_node("AnimatedSprite2D").flip_v = true
			position += Vector2(0, 10)
		elif input_direction.x == 1:
			rotate(PI/2)
			position += Vector2(20, -15)
		elif input_direction.x == -1:
			rotate(-PI/2)
			position += Vector2(-20, -15)
		elif(input_direction.x > 0 && input_direction.x < 1 or input_direction.x < 0 && input_direction.x > -1):
			queue_free()
	else:
			position += Vector2(0, -40)

func _on_animated_sprite_2d_animation_finished():
	queue_free()
