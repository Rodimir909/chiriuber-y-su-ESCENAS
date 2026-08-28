extends Node2D

func _on_Area2D_body_entered(body):
	if body.is_in_group("car"):
		$Sprite.visible=false
		GLOBAL.buscado=true

func _ready():
	# Buscamos el TileMap específico del pasto en el mapa
	var tilemap_pasto = get_tree().current_scene.find_node("pasto", true, false)
	
	if tilemap_pasto:
		orientar_hacia_la_calle(tilemap_pasto)

func orientar_hacia_la_calle(mapa_pasto: TileMap):
	# Pasamos la posición del pasajero a la celda del TileMap de pasto
	var pos_local = mapa_pasto.to_local(global_position)
	var celda = mapa_pasto.world_to_map(pos_local)
	
	# Revisamos si hay tile de pasto en las celdas adyacentes
	# (INVALID_CELL o -1 significa que está vacío, es decir, ahí no hay pasto)
	var hay_pasto_arriba = mapa_pasto.get_cell(celda.x, celda.y - 1) != TileMap.INVALID_CELL
	var hay_pasto_abajo = mapa_pasto.get_cell(celda.x, celda.y + 1) != TileMap.INVALID_CELL
	var hay_pasto_derecha = mapa_pasto.get_cell(celda.x + 1, celda.y) != TileMap.INVALID_CELL
	var hay_pasto_izquierda = mapa_pasto.get_cell(celda.x - 1, celda.y) != TileMap.INVALID_CELL
	
	if hay_pasto_arriba:
		rotation_degrees = 0     # Pasto arriba -> Mira abajo (a la calle)
	elif hay_pasto_abajo:
		rotation_degrees = 180   # Pasto abajo -> Mira arriba
	elif hay_pasto_derecha:
		rotation_degrees = 90   # Pasto a la derecha -> Mira a la izquierda
	elif hay_pasto_izquierda:
		rotation_degrees = -90    # Pasto a la izquierda -> Mira a la derecha
