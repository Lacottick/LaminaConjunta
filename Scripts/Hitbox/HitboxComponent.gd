extends Area2D

class_name HitboxComponent

@export var vida_component: VidaComponent

func dano(quantidade: int):
	if vida_component:
		vida_component.dano(quantidade)


func _on_body_entered(body):
	if(get_parent().has_method("body_entered")):
		get_parent().body_entered(body)
