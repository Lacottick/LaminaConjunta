extends Node2D

var enemyScene: PackedScene = preload("res://Scenes/Inimigo/Inimigo.tscn")

func _ready():
	randomize()

func _process(delta):
	pass
func _on_player_killed(body):
	pass
func _on_enemy_killed(body):
	body.get_parent().update_score()

func _on_enemy_timer_timeout():
	$EnemyPath/EnemySpawn.progress_ratio = randf()
	var enemy = enemyScene.instantiate()
	add_child(enemy)
	var direction = $EnemyPath/EnemySpawn.rotation + PI/2
	enemy.position = $EnemyPath/EnemySpawn.position
	var newDirection = randf_range(-PI/4, PI/4)
	direction += newDirection
	enemy.rotation = newDirection
	enemy.linear_velocity = Vector2(randf_range(enemy.min_speed,enemy.max_speed),0)
	enemy.linear_velocity = enemy.linear_velocity.rotated(direction)
	enemy.get_node("AnimatedSprite2D").play("default")


