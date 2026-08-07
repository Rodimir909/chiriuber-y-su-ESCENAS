extends Control

export (PackedScene) var JUGADOR

func _ready():
	$spawn.global_position=Vector2(GLOBAL.daa)
	var jugador = JUGADOR.instance()
	jugador.position = $spawn.position
	add_child(jugador)


func _on_SALIR_body_entered(body):
	if body.is_in_group("player"):
		GLOBAL.daa=Vector2(478,525)
		get_tree().change_scene("res://mapa/Mundo_Completo.tscn")


func _on_blackjack_body_entered(body):
	if body.is_in_group("player"):
		body.ca()
		$spawn.global_position=Vector2(GLOBAL.daa)
		get_tree().change_scene("res://CASINO FISICO INTERFAZ/blackjack/mesa.tscn")
		


func _on_ruleta_body_entered(body):
	if body.is_in_group("player"):
		body.ca()
		$spawn.global_position=Vector2(GLOBAL.daa)
		get_tree().change_scene("res://CASINO FISICO INTERFAZ/ruleta/ruletaa.tscn")
