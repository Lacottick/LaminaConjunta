extends CharacterBody2D

class_name Player

@export var speed:=250

@export var move_up: StringName
@export var move_down: StringName
@export var move_right: StringName
@export var move_left: StringName
@onready var animated_sprite = $AnimatedSprite2D
@export var vida_component: VidaComponent
@export var hitbox_component: HitboxComponent
var input_direction
#@onready var weapon = $Weapon

func _ready():
	y_sort_enabled = true

func get_input_animation()->void:
	input_direction = Input.get_vector(move_left, move_right, move_up, move_down);
	if(input_direction.length() >0):
		if(input_direction.y == -1):
			animated_sprite.play("walk_up");
		elif(input_direction.y == 1):
			animated_sprite.play("walk_down");
		if(input_direction.x == 1):
			animated_sprite.flip_h = false;
			animated_sprite.play("walk_side"); 
		elif(input_direction.x == -1):
			animated_sprite.flip_h = true;
			animated_sprite.play("walk_side");
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
			animated_sprite.play("idle");

func _physics_process(delta)->void:
	if(animated_sprite):
		get_input_animation()
		if(input_direction.length() > 0):
			if(input_direction.length() > 1):
				velocity =  input_direction * speed * 2;
			else:
				velocity =  input_direction * speed;
			move_and_slide();
			position.x = clamp(position.x, 0, get_viewport_rect().size.x)
			position.y = clamp(position.y, 0, get_viewport_rect().size.y)

func body_entered(body):
	if body is Inimigo:
		hitbox_component.dano(1)
