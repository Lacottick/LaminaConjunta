extends Area2D

class_name HitboxComponent

@export var vida_component: VidaComponent

func dano(quantidade: int):
	if vida_component:
		vida_component.dano(quantidade)
