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
	hitbox_component.connect("body_entered", _on_hitbox_component_body_entered)

func get_input_animation()->Vector2:
	input_direction = Input.get_vector(move_left, move_right, move_up, move_down);
	if(input_direction.length() >0):
		if(input_direction.y == -1):
			animated_sprite.play("walk_up");
		if(input_direction.y == 1):
			animated_sprite.play("walk_down");
		if(input_direction.x == 1):
			animated_sprite.flip_h = false;
			animated_sprite.play("walk_side"); 
		if(input_direction.x == -1):
			animated_sprite.flip_h = true;
			animated_sprite.play("walk_side");
		if(input_direction.x > 0 && input_direction.x < 1):
			if(input_direction.y < 0):
				animated_sprite.flip_h = true;
				animated_sprite.play("walk_diagonal_up")
			elif(input_direction.y > 0):
				animated_sprite.flip_h = false;
				animated_sprite.play("walk_diagonal_down");
		if(input_direction.x < 0 && input_direction.x > -1):
			if(input_direction.y < 0):
				animated_sprite.flip_h = false;
				animated_sprite.play("walk_diagonal_up")
			elif(input_direction.y > 0):
				animated_sprite.flip_h = true;
				animated_sprite.play("walk_diagonal_down");
	else:
		if(animated_sprite.is_playing()):
			animated_sprite.play("idle");
	return input_direction

func _physics_process(delta)->void:
	if(animated_sprite):
		get_input_animation()
		if(input_direction.length() > 0):
			if(input_direction.length() > 1):
				speed = 400
			else:
				speed = 250
			velocity =  input_direction * speed;
			move_and_slide();


func _on_hitbox_component_body_entered(body):
	print(body)
