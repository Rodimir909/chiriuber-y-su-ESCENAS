extends Node2D

export (PackedScene) var PLAYER

func _ready():
	var player = PLAYER.instance()
	player.position = GLOBAL.posiccion
	add_child(player)

func _on_puerta_body_entered(body):
	if body.is_in_group("player"):
		body.posicion()
		get_tree().change_scene("res://CASINO FISICO INTERFAZ/casino fisico.tscn")
