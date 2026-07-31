extends Control

onready var label = [$apuesta1, $apuesta2, $apuesta3]

var boton = []

var posicion : Vector2

var alea : int

var n : int = 200

var h = [0, 0, 0]

var hab : bool = true

var cant : float = 10

var c : int

var numruleta=[356, 131, 298, 15, 317, 170, 259, 54, 200, 93, 181, 219, 35, 239, 112, 337, 151, 278, 74, 327, 122, 307, 83, 190, 161, 288, 6, 249, 44, 64, 210, 103, 346, 142, 268, 25, 229]

func _ready():
# Recorremos TODOS los nodos que pusimos dentro del grupo "botones_apuesta"
	for boton in get_tree().get_nodes_in_group("apuesta"):
		# Conectamos la señal "pressed" de cada botón a UNA SOLA función
		# Y le pasamos el propio botón como argumento (BIND)
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
				for i in range(boton.size()):
					label[i].visible=false
				n=0
				hab=true
				cant=10
				h=[0, 0 ,0]
				boton=[]

		else:
			cant-=0.01
			c+=cant
			if c>=360:
				c=0
			$ruleta.rotation_degrees=c
		$limite.visible=false

func _on_boton_apuesta_pressed(boton_presionado: Button):
	# Obtenemos el nombre del nodo directamente (ej: "01", "02", "RED", "BLACK")
	if hab==true:
		var gg=false
		for i in range(boton.size()):
			if str(boton_presionado)==str(boton[i]):
				if h[i]<10:
					h[i]+=1
					label[i].text=str("x", h[i])
				else:
					if i==0:
						label[0].visible=false
						boton[0]=boton[2]
						h[0]=h[2]
						label[0]=label[2]
						label[0].text=str("x", h[0])
						boton.remove(2)
						h[2]=0
						
					elif i==1:
						label[1].visible=false
						boton[1]=boton[2]
						h[1]=h[2]
						label[1]=label[2]
						label[1].text=str("x", h[1])
						boton.remove(2)
					else:
						boton.remove(2)
				
				gg=true
				break
	#suma
		if gg==false:
			if boton.size()<3:
				boton.append(boton_presionado)
				var id_casillero : Vector2 = boton_presionado.rect_global_position
				id_casillero.x=id_casillero.x+47
				id_casillero.y=id_casillero.y+25
				label[(boton.size())-1].visible=true
				label[(boton.size())-1].rect_global_position=id_casillero
			else:
				$limite.visible=true
		print(boton)

func _on_Button_pressed():
	alea=GLOBAL.random(0,36)
	$ruleta.rotation_degrees=numruleta[alea]
	hab=false
	c=0
