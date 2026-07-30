extends Control

var posicion : Vector2

func _ready():
	posicion=$VBoxContainer/fila4/doce.rect_global_position
	posicion.x=posicion.x+50
	posicion.y=posicion.y+29
	$apuesta1.rect_global_position=posicion
# Recorremos TODOS los nodos que pusimos dentro del grupo "botones_apuesta"
	for boton in get_tree().get_nodes_in_group("apuesta"):
		# Conectamos la señal "pressed" de cada botón a UNA SOLA función
		# Y le pasamos el propio botón como argumento (BIND)
		boton.connect("pressed", self, "_on_boton_apuesta_pressed", [boton])
	
func _on_boton_apuesta_pressed(boton_presionado: Button):
	# Obtenemos el nombre del nodo directamente (ej: "01", "02", "RED", "BLACK")
	var id_casillero : String = boton_presionado.name
	
	print("Se presionó el botón: ", id_casillero)
