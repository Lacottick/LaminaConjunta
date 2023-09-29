extends CharacterBody2D

class_name Player

@export var speed:=250
@export var move_up: StringName
@export var move_down: StringName
@export var move_right: StringName
@export var move_left: StringName
@export var attack_key: StringName
@export var health_bar: HealthBar
@export var score_label: Label
@onready var animated_sprite = $AnimatedSprite2D
@export var vida_component: VidaComponent
@export var hitbox_component: HitboxComponent

var score: = 0
var input_direction = Vector2(0,0)
var direction: String = "down"
signal killed

func _ready():
	y_sort_enabled = true

func get_input_animation()->void:
	input_direction = Input.get_vector(move_left, move_right, move_up, move_down);
	if(input_direction.length() >0):
		if(input_direction.y == -1):
			animated_sprite.play("walk_up");
			direction = "up"
		elif(input_direction.y == 1):
			animated_sprite.play("walk_down");
			direction = "down"
		if(input_direction.x == 1):
			animated_sprite.flip_h = false;
			animated_sprite.play("walk_side"); 
			direction = "right"
		elif(input_direction.x == -1):
			animated_sprite.flip_h = true;
			animated_sprite.play("walk_side");
			direction = "left"
		elif(input_direction.x > 0 && input_direction.x < 1):
			if(input_direction.y < 0):
				animated_sprite.flip_h = true;
				animated_sprite.play("walk_diagonal_up")
			elif(input_direction.y > 0):
				animated_sprite.flip_h = false;
				animated_sprite.play("walk_diagonal_down");
		elif(input_direction.x < 0 && input_direction.x > -1):
			if(input_direction.y < 0):
				animated_sprite.flip_h = false;
				animated_sprite.play("walk_diagonal_up")
			elif(input_direction.y > 0):
				animated_sprite.flip_h = true;
				animated_sprite.play("walk_diagonal_down");
	else:
		if(animated_sprite.is_playing()):
			animated_sprite.stop()

func _physics_process(delta)->void:
	if(input_direction.length() > 0):
		if(input_direction.x > 0 && input_direction.x < 1 or input_direction.x < 0 && input_direction.x > -1):
			velocity =  input_direction * speed*1.25;
			hitbox_component.monitoring = false
			hitbox_component.monitorable = false
		else:
			velocity =  input_direction * speed;
			hitbox_component.monitoring = true
			hitbox_component.monitorable = true
		move_and_slide();
		position.x = clamp(position.x, 0, get_viewport_rect().size.x)
		position.y = clamp(position.y, 0, get_viewport_rect().size.y)

func _input(event):
	if(Input.is_action_just_pressed(attack_key)):
		attack()
	if(event is InputEventKey):
		get_input_animation()

func body_entered(body):
	if body is Inimigo:
		modulate = Color.RED
		var timer = Timer.new()
		timer.wait_time = 0.25
		timer.one_shot = true
		timer.connect("timeout", _on_timer_timeout)
		add_child(timer)
		timer.start(0.25)
		hitbox_component.dano(1)
		health_bar.update(vida_component.health, self.name)

func _on_timer_timeout():
	modulate = Color.WHITE

func attack():
	var attackScn
	if(self.name == "Lamina"):
		attackScn = preload("res://Scenes/Ataque/Corte.tscn")
		if(!has_node("Corte")):
			var attack = attackScn.instantiate()
			add_child(attack)
			attack.attack(direction)
	if(self.name == "Conjunta"):
		attackScn = preload("res://Scenes/Ataque/Magia.tscn")
		var attack = attackScn.instantiate()
		add_child(attack)
		attack.attack(direction)

func update_score():
	score+=1
	if(score % 3 == 0):
		vida_component.cura(1)
		health_bar.update(vida_component.health, self.name)
	if(score%10 == 0):
		if get_parent().get_node("EnemyTimer").wait_time > 0.1:
			get_parent().get_node("EnemyTimer").wait_time -= 0.05
	score_label.text = str(score)
