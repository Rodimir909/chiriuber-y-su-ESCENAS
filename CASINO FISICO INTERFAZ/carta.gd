extends Node2D

var mi_frame: int = 0
var esta_oculta: bool = false

func _ready():
	# Metemos la carta en un grupo para poder borrarla fácilmente después
	add_to_group("cartas_juego")

func configurar_carta(frame_id: int, oculta: bool = false):
	mi_frame = frame_id
	esta_oculta = oculta
	
	if esta_oculta:
		$AnimatedSprite.frame = 52
	else:
		$AnimatedSprite.frame = mi_frame

func dar_vuelta():
	if esta_oculta:
		esta_oculta = false
		$AnimatedSprite.frame = mi_frame
