extends Control

var posicion : Vector2

var alea : int

var n : int = 100

var hab : bool = true

var c : int

var numruleta=[356, 131, 298, 15, 317, 170, 259, 54, 200, 93, 181, 219, 35, 239, 112, 337, 151, 278, 74, 327, 122, 307, 83, 190, 161, 288, 6, 249, 44, 64, 210, 103, 346, 142, 268, 25, 229]

func _ready():
	posicion=$VBoxContainer/fila4/_11.rect_global_position
	posicion.x=posicion.x+50
	posicion.y=posicion.y+29
	$apuesta1.rect_global_position=posicion
# Recorremos TODOS los nodos que pusimos dentro del grupo "botones_apuesta"
	for boton in get_tree().get_nodes_in_group("apuesta"):
		# Conectamos la señal "pressed" de cada botón a UNA SOLA función
		# Y le pasamos el propio botón como argumento (BIND)
		boton.connect("pressed", self, "_on_boton_apuesta_pressed", [boton])
	
func _physics_process(delta):
	if hab==true:
		n+=1
		if n>=100:
			$apostar.disabled=false
			c+=10
			if c==360:
				c=0
			$ruleta.rotation_degrees=c
		
	if hab==false:
		$apostar.disabled=true
		if c>1:
			c-=0,5
		$ruleta.rot ation_degrees=c
		if c==numruleta[alea]:
			n=0
			hab=true
		

func _on_boton_apuesta_pressed(boton_presionado: Button):
	# Obtenemos el nombre del nodo directamente (ej: "01", "02", "RED", "BLACK")
	var id_casillero : String = boton_presionado.name

	print("Se presionó el botón: ", id_casillero.replace("_", ""))



func _on_Button_pressed():
	alea=GLOBAL.random(0,36)
	$ruleta.rotation_degrees=numruleta[alea]
	hab=false
	c=0
