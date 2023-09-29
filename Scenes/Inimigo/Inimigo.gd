extends RigidBody2D

class_name Inimigo

@export var vida_component: VidaComponent
@export var hitbox_component: HitboxComponent
@onready var animated_sprite = $AnimatedSprite2D
signal killed(body)
var min_speed:=200.0
var max_speed:=300.0
func _ready():
	connect("killed", get_parent()._on_enemy_killed)
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func body_entered(body:Node2D):
	if body.has_method("attack"):
		var timer = Timer.new()
		timer.wait_time = 0.25
		timer.one_shot = true
		timer.connect("timeout", _on_timer_timeout)
		add_child(timer)
		timer.start(0.25)
		modulate = Color.RED
		hitbox_component.dano(body.damage)
		killed.emit(body)

func _on_timer_timeout():
	modulate = Color.WHITE

