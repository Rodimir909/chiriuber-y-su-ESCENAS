extends Control

var posicion : Vector2

func _ready():
	posicion=$VBoxContainer/fila11/treintaydos.rect_global_position
	print(posicion.x+59,"-", posicion.y+38)
