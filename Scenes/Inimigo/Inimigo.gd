extends RigidBody2D

class_name Inimigo

@export var vida_component: VidaComponent
@export var hitbox_component: HitboxComponent
@onready var animated_sprite = $AnimatedSprite2D
var min_speed:=100.0
var max_speed:=200.0

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_hitbox_component_area_entered(area):
	if area.get_parent().has_method("get_damage"):
		queue_free()

func body_entered(body):
	if body.has_method("attack"):
		hitbox_component.dano(body.damage)
		var timer = Timer.new()
		timer.wait_time = 0.25
		timer.one_shot = true
		timer.connect("timeout", _on_timer_timeout)
		add_child(timer)
		timer.start(0.25)
		modulate = Color.RED

func _on_timer_timeout():
	modulate = Color.WHITE
