extends Control

var posicion : Vector2

var alea : int

var n : int = 200

var hab : bool = true

var cant : float = 10

var c : int

var numruleta=[356, 131, 298, 15, 317, 170, 259, 54, 200, 93, 181, 219, 35, 239, 112, 337, 151, 278, 74, 327, 122, 307, 83, 190, 161, 288, 6, 249, 44, 64, 210, 103, 346, 142, 268, 25, 229]

func _ready():
# Recorremos TODOS los nodos que pusimos dentro del grupo "botones_apuesta"
	for boton in get_tree().get_nodes_in_group("apuesta"):
		# Conectamos la señal "pressed" de cada botón a UNA SOLA función
		# Y le pasamos el propio botón como argumento (BIND)
		print(boton)
		boton.connect("pressed", self, "_on_boton_apuesta_pressed", [boton])
	
func _physics_process(delta):
	if hab==true:
		n+=1
		if n>=200:
			$apostar.disabled=false
			c+=cant
			if c==360:
				c=0
			$ruleta.rotation_degrees=c
		
	if hab==false:
		$apostar.disabled=true
		if cant<=1:
			c+=1
			if c>=360:
				c=0
			$ruleta.rotation_degrees=c
			if c==numruleta[alea]:
				n=0
				hab=true
				cant=10
		else:
			cant-=0.01
			c+=cant
			if c>=360:
				c=0
			$ruleta.rotation_degrees=c

func _on_boton_apuesta_pressed(boton_presionado: Button):
	# Obtenemos el nombre del nodo directamente (ej: "01", "02", "RED", "BLACK")
	var id_casillero : Vector2 = boton_presionado.rect_global_position
	id_casillero.x=id_casillero.x+47
	id_casillero.y=id_casillero.y+25
	$apuesta1.visible=true
	$apuesta1.rect_global_position=id_casillero
	print("Se presionó el botón: ", id_casillero)



func _on_Button_pressed():
	alea=GLOBAL.random(0,36)
	$ruleta.rotation_degrees=numruleta[alea]
	hab=false
	c=0
