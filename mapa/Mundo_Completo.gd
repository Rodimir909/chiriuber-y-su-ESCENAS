extends Node2D

export (PackedScene) var CELU
export (PackedScene) var PASAJERO
export (PackedScene) var DESTINO

signal taler

onready var tilemap = $vereda
const ID_VEREDA = 0 

var escenacasino = preload("res://CASINO FISICO INTERFAZ/casino fisico.tscn")
var instancia = null

func _ready():
	GLOBAL.connect("aceptado", self, "estanciado0")
	GLOBAL.connect("establecerpunto", self, "estanciado1")
	GLOBAL.connect("viaje", self, "generar_viaje_uber")
	GLOBAL.connect("esconcasino", self, "escondercasino")
	if GLOBAL.pos == "casino":
		$KinematicBody2D.position = Vector2(9200,8000)
		$Auto.position = Vector2(9300,8000)
		GLOBAL.pos = ""
	elif GLOBAL.pos == "taller":
		emit_signal("taler")
		$Auto.position = Vector2(10931,2630)
		$Auto.rotate(deg2rad(90))
		GLOBAL.pos = ""

func escondercasino():
	instancia.queue_free()
	instancia=null
	$KinematicBody2D/Camera2D.current = true

func estanciado1():
	var destino = DESTINO.instance()
	destino.position = GLOBAL.destino_pasajero
	add_child(destino)

func estanciado0():
	var pasajero = PASAJERO.instance()
	pasajero.position = GLOBAL.origen_pasajero
	add_child(pasajero)

func generar_viaje_uber():
	GLOBAL.origen_pasajero = obtener_punto_de_viaje_aleatorio()
	GLOBAL.destino_pasajero = obtener_punto_de_viaje_aleatorio()
	
	while GLOBAL.origen_pasajero.distance_to(GLOBAL.destino_pasajero) < 500:
		GLOBAL.destino_pasajero = obtener_punto_de_viaje_aleatorio()
	


func obtener_punto_de_viaje_aleatorio() -> Vector2:
	randomize()
	var celdas_vereda = tilemap.get_used_cells_by_id(ID_VEREDA)
	
	if celdas_vereda.empty():
		print("¡Atención! No se encontraron tiles con el ID ", ID_VEREDA)
		return Vector2.ZERO
	
	var celda_aleatoria = celdas_vereda[randi() % celdas_vereda.size()]
	var pos_local = tilemap.map_to_world(celda_aleatoria) + (tilemap.cell_size / 2)
	var posicion_global = tilemap.to_global(pos_local)
	
	return posicion_global
   

func _on_puerta_body_entered(body):
	if body.is_in_group("player"):
		GLOBAL.pos = "casino"
		instancia = escenacasino.instance()
		
		$estructura.add_child(instancia)
		

func _on_KinematicBody2D_down():
	$KinematicBody2D.position = $Auto.position


func _on_Puerta2_body_entered(body):
	
	if body.is_in_group("car"):
		GLOBAL.pos = "taller"
		get_tree().change_scene("res://TALLER/taller_interfaz.tscn")
