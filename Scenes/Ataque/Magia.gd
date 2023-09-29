extends RigidBody2D


var damage = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func attack(direction):
	var directionVector = Vector2(1,1)
	match(direction):
		"up":
			directionVector = Vector2(0, -1)
		"down":
			rotate(-PI)
			directionVector = Vector2(0, 1)
		"right":
			rotate(PI/2)
			directionVector = Vector2(1, 0)
		"left":
			rotate(-PI/2)
			directionVector = Vector2(-1, 0)
	linear_velocity = directionVector*700

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
