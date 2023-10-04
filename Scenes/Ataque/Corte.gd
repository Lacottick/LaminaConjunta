extends StaticBody2D

var damage = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func attack(direction):
	match(direction):
		"up":
			position += Vector2(0, -40)
		"down":
			rotate(-PI)
			position += Vector2(0, 10)
		"right":
			rotate(PI/2)
			position += Vector2(20, -15)
		"left":
			rotate(-PI/2)
			position += Vector2(-20, -15)
func _on_animated_sprite_2d_animation_finished():
	queue_free()
