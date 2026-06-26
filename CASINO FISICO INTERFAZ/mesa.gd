extends Control

export (PackedScene) var carta

var lugarus: int = 0
var lugarpc: int = 0
var contador: int = 0

var losbool: bool = false

var apuesta:int

var u: bool = true
var e: bool = true

var quemaneradevercontadoreus: int = -1
var quemaneradevercontadorepc: int = -1

var veces: int = 0

var la_carta_oculta_de_la_pc = null


func cartas_pc(ocultar_esta: bool = false):
	lugarpc += 20
	var nueva_carta = carta.instance()
	$pc/PathFollow2D.set_offset(lugarpc)
	nueva_carta.position = $pc/PathFollow2D.position
	
	var frame_id = GLOBAL.cartaspc[quemaneradevercontadorepc]
	nueva_carta.configurar_carta(frame_id, ocultar_esta)
	
	if ocultar_esta == true:
		la_carta_oculta_de_la_pc = nueva_carta
		
	add_child(nueva_carta)
	
func cartas_us():
	lugarus += 20
	var nueva_carta = carta.instance()
	$us/PathFollow2D.set_offset(lugarus)
	nueva_carta.position = $us/PathFollow2D.position
	
	var frame_id = GLOBAL.cartasus[quemaneradevercontadoreus]
	nueva_carta.configurar_carta(frame_id, false)
	add_child(nueva_carta)

func _ready():
	if GLOBAL.peso>=100:
		apuesta=100
	else:
		apuesta=GLOBAL.peso
	$VBoxContainer/HBoxContainer/apuesta.text=str(apuesta)
	

#----------------REPARTIR------------------------------------------------

func _physics_process(delta):
	$Label.text=str(GLOBAL.peso)
	print(GLOBAL.peso)
	if losbool == true and veces < 400:
		contador += 1
		if contador == 100:
			$HBoxContainer2/AnimatedSprite.play("default")
			
			if u == true:
				e = true
				u = false
				quemaneradevercontadoreus += 1
				cartas_us()
				$HBoxContainer2/AnimatedSprite.frame = 0
				
				var valor_carta = (GLOBAL.cartasus[quemaneradevercontadoreus] % 13) + 1
				if valor_carta > 10: valor_carta = 10
				GLOBAL.puntosdelus += valor_carta
				$puntosus.text = str(GLOBAL.puntosdelus)
				
			elif e == true:
				e = false
				u = true
				quemaneradevercontadorepc += 1
				
				if quemaneradevercontadorepc == 1:
					cartas_pc(true)
				else:
					cartas_pc(false)
					
				$HBoxContainer2/AnimatedSprite.frame = 0
				
				var valor_carta = (GLOBAL.cartaspc[quemaneradevercontadorepc] % 13) + 1
				if valor_carta > 10: valor_carta = 10
				GLOBAL.puntosdelpc += valor_carta
				$puntospc.text = str("?")
				
			contador = 0

		veces += 1
	
	if veces >= 400 and losbool == true:
		losbool = false

		if GLOBAL.puntosdelus == 21:
			_on_plantarse_pressed()



func _on_repartir_pressed():
	GLOBAL.peso-=apuesta
	var cartas_viejas = get_tree().get_nodes_in_group("cartas_juego")
	for c in cartas_viejas:
		c.queue_free()
		
	GLOBAL.cartasus.clear()
	GLOBAL.cartaspc.clear()
	GLOBAL.puntosdelus = 0
	GLOBAL.puntosdelpc = 0
	quemaneradevercontadoreus = -1
	quemaneradevercontadorepc = -1
	lugarus = 0
	lugarpc = 0
	veces = 0
	contador = 0
	la_carta_oculta_de_la_pc = null
	u = true
	e = true
	
	$puntosus.text = "0"
	$puntospc.text = "0"
	
	var usadas = []
	while usadas.size() < 4:
		var numero_random = GLOBAL.random(0, 51)
		if not (numero_random in usadas):
			usadas.append(numero_random)
			
	GLOBAL.cartasus.append(usadas[0])
	GLOBAL.cartaspc.append(usadas[1])
	GLOBAL.cartasus.append(usadas[2])
	GLOBAL.cartaspc.append(usadas[3])
	
	$HBoxContainer/VBoxContainer/pedir.disabled = true
	$HBoxContainer/VBoxContainer/plantarse.disabled = true
	$HBoxContainer/VBoxContainer2/doblar.disabled = true
	$HBoxContainer/VBoxContainer2/repartir.disabled = true
	
	losbool = true
	
	yield(get_tree().create_timer(4.1), "timeout")
	if GLOBAL.puntosdelus < 21: # Si no hizo blackjack directo
		$HBoxContainer/VBoxContainer/pedir.disabled = false
		$HBoxContainer/VBoxContainer/plantarse.disabled = false
		$HBoxContainer/VBoxContainer2/doblar.disabled = false


func _on_pedir_pressed():

	$HBoxContainer/VBoxContainer2/doblar.disabled = true
	
	var numero_random = GLOBAL.random(0, 51)
	while (numero_random in GLOBAL.cartasus) or (numero_random in GLOBAL.cartaspc):
		numero_random = GLOBAL.random(0, 51)
		
	GLOBAL.cartasus.append(numero_random)
	quemaneradevercontadoreus += 1
	
	cartas_us()
	
	var valor_carta = (numero_random % 13) + 1
	if valor_carta > 10: valor_carta = 10
	GLOBAL.puntosdelus += valor_carta
	$puntosus.text = str(GLOBAL.puntosdelus)
	
	if GLOBAL.puntosdelus > 21:
		_on_plantarse_pressed()

func _on_doblar_pressed():
	# [LOGICA MONETARIA]: Tu_Variable_Dinero -= Apuesta_Actual (Duplicás el pozo)
	

	var numero_random = GLOBAL.random(0, 51)
	while (numero_random in GLOBAL.cartasus) or (numero_random in GLOBAL.cartaspc):
		numero_random = GLOBAL.random(0, 51)
		
	GLOBAL.cartasus.append(numero_random)
	quemaneradevercontadoreus += 1
	cartas_us()
	
	var valor_carta = (numero_random % 13) + 1
	if valor_carta > 10: valor_carta = 10
	GLOBAL.puntosdelus += valor_carta
	$puntosus.text = str(GLOBAL.puntosdelus)
	
	_on_plantarse_pressed()

func _on_plantarse_pressed():
	$HBoxContainer/VBoxContainer/pedir.disabled = true
	$HBoxContainer/VBoxContainer2/doblar.disabled = true
	$HBoxContainer/VBoxContainer/plantarse.disabled = true
	
	if la_carta_oculta_de_la_pc != null:
		la_carta_oculta_de_la_pc.dar_vuelta()
	
	$puntospc.text = str(GLOBAL.puntosdelpc)
	
# --------------------------CRUPIER ---------------------------------------------------
	if GLOBAL.puntosdelus <= 21:
		while GLOBAL.puntosdelpc < 17:
			yield(get_tree().create_timer(0.8), "timeout") # Pausa dramática entre cartas de la PC
			
			var numero_random = GLOBAL.random(0, 51)
			while (numero_random in GLOBAL.cartasus) or (numero_random in GLOBAL.cartaspc):
				numero_random = GLOBAL.random(0, 51)
				
			GLOBAL.cartaspc.append(numero_random)
			quemaneradevercontadorepc += 1
			cartas_pc(false) # Salen visibles
			
			var valor_carta = (numero_random % 13) + 1
			if valor_carta > 10: valor_carta = 10
			GLOBAL.puntosdelpc += valor_carta
			$puntospc.text = str(GLOBAL.puntosdelpc)
			
	# Esperamos un cachito final y definimos al ganador
	yield(get_tree().create_timer(0.5), "timeout")
	comprobar_ganador()

#------------------------GANADOR--------------------------------------------

func comprobar_ganador():
	var u_puntos = GLOBAL.puntosdelus
	var pc_puntos = GLOBAL.puntosdelpc
	
	print("--- FIN DE LA PARTIDA ---")
	if u_puntos > 21:
		print("Perdiste! Te pasaste de 21.")

	elif pc_puntos > 21:
		print("Ganaste! El crupier se pasó.")
		GLOBAL.peso+=apuesta*2
	elif u_puntos > pc_puntos:
		print("Ganaste por mayor puntaje!")
		GLOBAL.peso+=apuesta*2
	elif pc_puntos > u_puntos:
		print("Perdiste. El crupier tiene mejor mano.")

	else:
		print("Empate! Se devuelve la apuesta.")
		GLOBAL.peso+=apuesta

	$HBoxContainer/VBoxContainer2/repartir.disabled = false
	if GLOBAL.peso>=100:
		apuesta=100
	else:
		apuesta=GLOBAL.peso
	$VBoxContainer/HBoxContainer/apuesta.text=str(apuesta)

func _on_MAS_pressed():
	if GLOBAL.peso>apuesta:
		apuesta+=100
		if apuesta>GLOBAL.peso:
			apuesta=GLOBAL.peso
			$VBoxContainer/HBoxContainer/apuesta.text=str(apuesta)
		$VBoxContainer/HBoxContainer/apuesta.text=str(apuesta)
	else:
		$VBoxContainer/HBoxContainer/apuesta.modulate=Color.red
		yield(get_tree().create_timer(0.15), "timeout")
		$VBoxContainer/HBoxContainer/apuesta.modulate=Color.white


func _on_MENOS_pressed():
	if apuesta>0 and apuesta<=100:
		$VBoxContainer/HBoxContainer/apuesta.modulate=Color.red
		yield(get_tree().create_timer(0.15), "timeout")
		$VBoxContainer/HBoxContainer/apuesta.modulate=Color.white
		$VBoxContainer/HBoxContainer/apuesta.text=str(apuesta)
	elif apuesta>100:
		apuesta-=100
		$VBoxContainer/HBoxContainer/apuesta.text=str(apuesta)
	else:
		$VBoxContainer/HBoxContainer/apuesta.text=str(apuesta)
