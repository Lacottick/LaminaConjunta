extends Node2D


class_name VidaComponent

@export var max_health:=3
var health:=max_health

func dano(quantidade: int):
	health -=quantidade
	if(health == 0):
		get_parent().queue_free()
func cura(quantidade: int):
	health += quantidade
	if(health > max_health):
		health = max_health

func _process(delta):
	pass
