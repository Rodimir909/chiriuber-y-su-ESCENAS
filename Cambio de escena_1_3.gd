extends Area2D


export (String, FILE, "*.tscn") var proxima_Mapa

export(Vector2) var nueva_posicion_jugador



func _on_Cambio_de_escena_1_3_body_entered(body):
	if body.is_in_group ("player"):
		GLOBAL.posicion_aparicion = nueva_posicion_jugador
		GLOBAL.teletrasportarse = true 
		get_tree().change_scene("res://mapa/Mapa_3.tscn")

	
