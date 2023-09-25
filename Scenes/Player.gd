extends CharacterBody2D

class_name Player

@export var speed:=500

var move_up: StringName
var move_down: StringName
var move_right: StringName
var move_left: StringName

var animated_sprite: AnimatedSprite2D


func _init(move_up: StringName, move_down: StringName, move_right: StringName, move_left: StringName, player: int):
	self.move_up = move_up
	self.move_down = move_down
	self.move_right = move_right
	self.move_left = move_left
	animated_sprite = AnimatedSprite2D.new()
	animated_sprite.sprite_frames = load("res://Assets/SpriteFrames_player"+str(player)+".tres")
	y_sort_enabled = true
	add_child(animated_sprite)

func get_input_animation()->Vector2:
	var input_direction := Input.get_vector(move_left, move_right, move_up, move_down);
	if(input_direction.length() > 0):
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
		animated_sprite.play("idle");
	return input_direction

func _physics_process(delta)->void:
	var input_direction = get_input_animation()
	velocity =  input_direction * speed;
	move_and_slide();
	position.x = clamp(position.x, 0, get_viewport_rect().size.x)
	position.y = clamp(position.y, 0, get_viewport_rect().size.y)
