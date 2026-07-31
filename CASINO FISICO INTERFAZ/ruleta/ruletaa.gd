extends Control

onready var label = [$apuesta1, $apuesta2, $apuesta3]

var numruleta=[356, 131, 298, 15, 317, 170, 259, 54, 200, 93, 181, 219, 35, 239, 112, 337, 151, 278, 74, 327, 122, 307, 83, 190, 161, 288, 6, 249, 44, 64, 210, 103, 346, 142, 268, 25, 229]

var negros= [1, 3, 5, 7, 9, 12, 14, 16, 18, 19, 21, 23, 25, 27, 30, 32, 34, 36]

var rojos = [2, 4, 6, 8, 10, 11, 13, 15, 17, 20, 22, 24, 26, 28, 29, 31, 33, 35]

var h = [0, 0, 0]

var boton = []

var n : int = 200

var cant : float = 10

var hab : bool = true

var posicion : Vector2

var alea : int

var g : int = -1

var c : int

var lab : Object

var compro : bool

var apuesta:int

func analizar():
	for i in range(boton.size()):
		if (boton[i].name).replace("_", "")==str(alea):
			GLOBAL.peso+=apuesta*35
		elif alea==0:
			if (boton[i].name).replace("_", "")=="0":
				GLOBAL.peso+=apuesta*35
			else:
				GLOBAL.peso-=apuesta
		elif (boton[i].name).replace("columna", "") == str(alea%3) or (boton[i].name).replace("_", "")==str(int(((alea-1)%12)+1)):
			GLOBAL.peso+=apuesta*3
		elif ((boton[i].name)=="Even" and alea%2==0) or ((boton[i].name)=="Odd" and alea%2==1) or ((boton[i].name).replace("_", "")=="1to18" and (alea>0 and alea<19)) or ((boton[i].name).replace("_", "")=="19to36" and (alea>18 and alea<37)):
			GLOBAL.peso+=apuesta*2
		elif boton[i].name=="Rlack":
			compro=true
			for k in range(negros.size()):
				if alea==negros[k]:
					GLOBAL.peso+=apuesta*2
					compro=false
			if compro==true:
				GLOBAL.peso-=apuesta
		elif boton[i].name=="Red":
			compro=true
			for k in range(rojos.size()):
				if alea==rojos[k]:
					GLOBAL.peso+=apuesta*2
					compro=false
			if compro==true:
				GLOBAL.peso-=apuesta
		else:
			GLOBAL.peso-=apuesta
func _ready():
	if GLOBAL.peso>=100:
		apuesta=100
	else:
		apuesta=GLOBAL.peso
	$VBoxContainer4/HBoxContainer/apuesta.text=str(apuesta)
# Recorremos TODOS los nodos que pusimos dentro del grupo "botones_apuesta"
	for boton in get_tree().get_nodes_in_group("apuesta"):
		# Conectamos la señal "pressed" de cada botón a UNA SOLA función
		# Y le pasamos el propio botón como argumento (BIND)
		boton.connect("pressed", self, "_on_boton_apuesta_pressed", [boton])
	
func _physics_process(delta):
	if g<0:
		$apostar.disabled=true
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
				analizar()
				for i in range(boton.size()):
					label[i].visible=false
				n=0
				hab=true
				cant=10
				h=[0, 0 ,0]
				boton=[]
				g=-1
				if GLOBAL.peso>=100:
					apuesta=100
				else:
					apuesta=GLOBAL.peso
				$VBoxContainer4/HBoxContainer/apuesta.text=str(apuesta)

		else:
			cant-=0.01
			c+=cant
			if c>=360:
				c=0
			$ruleta.rotation_degrees=c
		$texto.visible=false

func _on_boton_apuesta_pressed(boton_presionado: Button):
	if GLOBAL.peso>0:
	# Obtenemos el nombre del nodo directamente (ej: "01", "02", "RED", "BLACK")
		if hab==true:
			var gg=false
			for i in range(boton.size()):
				if str(boton_presionado)==str(boton[i]):
					if h[i]<10:
						h[i]+=1
						label[i].text=str("x", h[i])
					else:
						g-=1
						if boton.size()==3:
							if i==0:
								label[0].visible=false
								boton[0]=boton[2]
								h[0]=h[2]
								lab=label[2]
								label[2]=label[0]
								label[0]=lab
								label[0].text=str("x", h[0])
								boton.remove(2)
								h[2]=0
							elif i==1:
								label[1].visible=false
								boton[1]=boton[2]
								h[1]=h[2]
								lab=label[2]
								label[2]=label[1]
								label[1]=lab
								label[1].text=str("x", h[1])
								boton.remove(2)
								h[2]=0
							else:
								label[2].visible=false
								h[2]=0
								boton.remove(2)
						elif boton.size()==2:
							if i==0:
								label[0].visible=false
								boton[0]=boton[1]
								h[0]=h[1]
								lab=label[1]
								label[1]=label[0]
								label[0]=lab
								label[0].text=str("x", h[0])
								boton.remove(1)
								h[1]=0
							else:
								label[1].visible=false
								h[1]=0
								boton.remove(1)
						elif boton.size()==1:
							label[0].visible=false
							h[0]=0
							boton.remove(0)
					gg=true
					break
		#suma
			if gg==false:
				if boton.size()<3:
					g+=1
					boton.append(boton_presionado)
					var id_casillero : Vector2 = boton_presionado.rect_global_position
					id_casillero.x=id_casillero.x+47
					id_casillero.y=id_casillero.y+25
					label[(boton.size())-1].visible=true
					label[(boton.size())-1].rect_global_position=id_casillero
					h[g]+=1
					label[g].text=str("x", h[g])
				else:
					$texto.text=str("NO MAS DE 3")
					$texto.visible=true

func _on_Button_pressed():
	if GLOBAL.peso>0:
		alea=GLOBAL.random(0,36)
		$ruleta.rotation_degrees=numruleta[alea]
		hab=false
		c=0
	else:
		$VBoxContainer4/HBoxContainer/apuesta.modulate=Color.red
		yield(get_tree().create_timer(0.15), "timeout")
		$VBoxContainer4/HBoxContainer/apuesta.modulate=Color.white

func _on_menos_pressed():
	if apuesta>0 and apuesta<=100:
		$VBoxContainer4/HBoxContainer/apuesta.modulate=Color.red
		yield(get_tree().create_timer(0.15), "timeout")
		$VBoxContainer4/HBoxContainer/apuesta.modulate=Color.white
		$VBoxContainer4/HBoxContainer/apuesta.text=str("$", apuesta)
	elif apuesta>100:
		apuesta-=100
		$VBoxContainer4/HBoxContainer/apuesta.text=str("$", apuesta)
	else:
		$VBoxContainer4/HBoxContainer/apuesta.text=str("$", apuesta)

func _on_mas_pressed():
	if GLOBAL.peso>apuesta:
		apuesta+=100
		if apuesta>GLOBAL.peso:
			apuesta=GLOBAL.peso
			$VBoxContainer4/HBoxContainer/apuesta.text=str(apuesta)
		$VBoxContainer4/HBoxContainer/apuesta.text=str(apuesta)
	else:
		$VBoxContainer4/HBoxContainer/apuesta.modulate=Color.red
		yield(get_tree().create_timer(0.15), "timeout")
		$VBoxContainer4/HBoxContainer/apuesta.modulate=Color.white
